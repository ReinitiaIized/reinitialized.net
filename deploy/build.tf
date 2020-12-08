# define providers
## vSphere
provider vsphere {
    user                      = var.vsphere_username
    password                  = var.vsphere_password

    version                   = "1.24.2"
    vsphere_server            = "vc.in.reinitialized.net"
    allow_unverified_ssl      = false ### we're now using LetsEncrypt. TODO: figure method to automatically renew and publish certificates
}

# define data sources
## vSphere
### datacenter: reinitialized.net
data vsphere_datacenter dc {
    name = "reinitialized.net"
}
### datastore: vsanDatastore
data vsphere_datastore ds {
    name            = "vsanDatastore"
    datacenter_id   = data.vsphere_datacenter.dc.id
}

### compute cluster: alpha
data vsphere_compute_cluster alpha {
    name            = "alpha"
    datacenter_id = data.vsphere_datacenter.dc.id
}

### resource pool: in
### root rp for in.reinitialized.net
resource vsphere_resource_pool in {
    name                    = "in"
    parent_resource_pool_id = data.vsphere_compute_cluster.alpha.resource_pool_id
}
### resource pool: in/core
### core services on alpha
resource vsphere_resource_pool core {
    name                    = "core"
    parent_resource_pool_id = data.vsphere_resource_pool.in.resource_pool_id
}
### resource pool: in/home
### services for homeprod
resource vsphere_resource_pool home {
    name                    = "home"
    parent_resource_pool_id = data.vsphere_resource_pool.core.resource_pool_id
}
### resource pool: in/rancher
resource vsphere_resource_pool rancher {
    name                    = "rancher"
    parent_resource_pool_id = data.vsphere_compute_cluster.alpha.resource_pool_id
}

### distributed vswitch: core
data vsphere_distributed_virtual_switch core {
    name = "core"
    datacenter_id = data.vsphere_datacenter.dc.id
}
### network: core/management
data vsphere_network management {
    name = "management"
    datacenter_id = data.vsphere_datacenter.dc.id
}
### network: core/iservice
data vsphere_network iservice {
    name = "iservice"
    datacenter_id = data.vsphere_datacenter.dc.id
}
### network: core/eservice
data vsphere_network eservice {
    name = "eservice"
    datacenter_id = data.vsphere_datacenter.dc.id
}
### network: core/testing 
data vsphere_network testing {
    name = "testing"
    datacenter_id = data.vsphere_datacenter.dc.id
}

### vm: templates/ubnt20lts
data vsphere_virtual_machine ubnt20lts {
    name = "ubnt20lts"
    datacenter_id = data.vsphere_datacenter.dc.id
}
### vm: templates/cos8
data vsphere_virtual_machine cos8 {
    name = "cos8"
    datacenter_id = data.vsphere_datacenter.dc.id
}

# define resources
## VM: dns1.in.reinitialized.net
resource vsphere_virtual_machine "dns1.core" {
    name = "dns1.core"
    resource_pool_id = data.vsphere_resource_pool.core.resource_pool_id
    datastore_id    = data.vsphere_datastore.id

    num_cpus = 2
    memory = 2048
    guest_id = "ubuntu64Guest"

    network_interface {
        network_id = data.vsphere_network.iservice.id
    }
}




resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "terraform-test"
        domain    = "test.internal"
      }

      network_interface {
        ipv4_address = "10.0.0.10"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.0.0.1"
    }
  }
}