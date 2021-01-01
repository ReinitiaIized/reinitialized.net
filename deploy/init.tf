resource vsphere_virtual_machine cdh1 {
  name = "cdh1.core"
  resource_pool_id = vsphere_resource_pool.core.id
  datastore_id = data.vsphere_datastore.vsan.id

  num_cpus = 2
  memory = 4096
  guest_id = data.vsphere_virtual_machine.ubuntu.guest_id
  firmware = data.vsphere_virtual_machine.ubuntu.firmware

  network_interface {
    network_id = data.vsphere_network.services.id
    adapter_type = data.vsphere_virtual_machine.ubuntu.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size = data.vsphere_virtual_machine.ubuntu.disks.0.size
    eagerly_scrub = data.vsphere_virtual_machine.ubuntu.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.ubuntu.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
  }

  provisioner "local-exec" {
    command = "ansible cdh1/config.yml -i ${vsphere_virtual_machine.cdh1.default_ip_address}, -e \"ansible_user=root ansible_password=provision\""
  }
}