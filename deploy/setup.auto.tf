# define variables
variable vsphere_username {
    default = "provisioner@in.reinitialized.net"
}
variable vsphere_allow_unverified_ssl {
    default = false
}
variable vsphere_password {}

# define providers
provider vsphere {
    user                    = var.vsphere_username
    password                = var.vsphere_password
    vsphere_server          = "vc.in.reinitialized.net"
    allow_unverified_ssl    = var.vsphere_allow_unverified_ssl  
}

# configure Terraform
terraform {
    required_version = "~> 0.14.0"
    required_providers {
        vsphere = {
            version = "~> 1.24.0"
            source = "hashicorp/vsphere"
        }
    }
}

# setup environment
## reference existing resources
data vsphere_datacenter dc {
    name = "reinitialized.net"
}
data vsphere_compute_cluster alpha {
    name = "alpha"
    datacenter_id = data.vsphere_datacenter.dc.id
}
data vsphere_datastore vsan {
    name = "vsanDatastore"
    datacenter_id = data.vsphere_datacenter.dc.id
}
data vsphere_network services {
    name = "iservices"
    datacenter_id = data.vsphere_datacenter.dc.id
}

## define resource pools
resource vsphere_resource_pool in {
    name = "in"
    parent_resource_pool_id = data.vsphere_compute_cluster.alpha.resource_pool_id
}
resource vsphere_resource_pool core {
    name = "core"
    parent_resource_pool_id = vsphere_resource_pool.in.id
}
resource vsphere_resource_pool home {
    name = "home"
    parent_resource_pool_id = data.vsphere_compute_cluster.alpha.resource_pool_id
}

## define VM templates
data vsphere_virtual_machine centos {
    name = "cos8"
    datacenter_id = data.vsphere_datacenter.dc.id
}
data vsphere_virtual_machine ubuntu {
    name = "ubnt20lts"
    datacenter_id = data.vsphere_datacenter.dc.id
}