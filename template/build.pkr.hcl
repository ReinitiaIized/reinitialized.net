# Define variables
## vSphere
variable username {
    default = "provisioner"
}
variable password {}
## Template
variable floppy_files {
    type    = list(string)
    default = []
}
variable cpus {
    default = 2
}
variable ram {
    default = 1024
}
variable shutdown_command {
    default = "shutdown now"
}
variable firmware {
    default = "efi-secure"
}
variable floppy_label {
    default = "cidata"
}
variable http_directory {
    default = ""
}
variable playbook_file {}
variable boot_command {}
variable guest_os {}
variable iso_url {}
variable iso_checksum {}
variable template_name {}

source vsphere-iso template {
    ## vCenter Settings
    vcenter_server              = "vc.in.reinitialized.net"
    username                    = var.username
    password                    = var.password
    insecure_connection         = false # TODO: automate SSL renewal

    ## Where to store
    datacenter                  = "reinitialized.net"
    cluster                     = "alpha"
    datastore                   = "vsanDatastore"
    folder                      = "templates"
    convert_to_template         = true

    ## VM hardware
    CPUs                        = var.cpus
    CPU_hot_plug                = true
    RAM                         = var.ram
    RAM_hot_plug                = true
    boot_wait                   = "5s"
    boot_command                = var.boot_command
    firmware                    = var.firmware
    guest_os_type               = var.guest_os
    disk_controller_type        = ["pvscsi"]
    storage {
        disk_size = 20480
        disk_thin_provisioned = true
    }
    network_adapters {
        network = "testing"
        network_card = "vmxnet3"
    }

    ## VM settings
    vm_name                     = var.template_name
    cdrom_type                  = "sata"
    iso_url                     = var.iso_url
    iso_checksum                = var.iso_checksum

    ## Communicator settings
    ip_wait_timeout             = "60m"
    communicator                = "ssh"
    ssh_username                = "root"
    ssh_password                = "provision"
    ssh_timeout                 = "30m"
    ssh_port                    = 22
    ssh_handshake_attempts      = 80
    shutdown_timeout            = "10m"
    shutdown_command            = var.shutdown_command

    ## http for automated installs
    http_directory              = var.http_directory
    #http_ip                     = "172.16.0.2"

    ## floppy for ubuntu (since its broken)
    floppy_label                = var.floppy_label
    floppy_files                = var.floppy_files
}

build {
    sources = [
        "source.vsphere-iso.template"
    ]
    provisioner ansible {
        playbook_file = var.playbook_file
    }
}

