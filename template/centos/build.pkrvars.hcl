cpus                = 2
ram                 = 2048
boot_command        = [
    "<up>e<down><down><end>",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.cfg",
    "<leftCtrlOn>x<leftCtrlOff>"
]
guest_os            = "centos8_64Guest"
template_name       = "cos8"
shutdown_command    = "shutdown now"
iso_url             = "https://mirror.dal10.us.leaseweb.net/centos/8/isos/x86_64/CentOS-8.3.2011-x86_64-boot.iso"
iso_checksum        = "file:https://mirror.dal10.us.leaseweb.net/centos/8/isos/x86_64/CHECKSUM"
http_directory      = "centos/config/http"
playbook_file       = "centos/config/prep.yml"