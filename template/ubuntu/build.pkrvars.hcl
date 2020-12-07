cpus                = 4
ram                 = 3072
boot_command        = [
    "<esc><esc><esc>",
    "<enter><wait>",
    #"set gfxpayload=keep", "<enter>",
    "linux /casper/vmlinuz ip=dhcp quiet autoinstall ds=nocloud;", "<enter>",
    "initrd /casper/initrd", "<enter>",
    "boot", "<enter>"
]
guest_os            = "ubuntu64Guest"
template_name       = "ubnt20lts"
shutdown_command    = "shutdown now"
iso_url             = "https://releases.ubuntu.com/20.04.1/ubuntu-20.04.1-live-server-amd64.iso"
iso_checksum        = "443511f6bf12402c12503733059269a2e10dec602916c0a75263e5d990f6bb93"
floppy_files        = [
    "ubuntu/config/user-data",
    "ubuntu/config/meta-data"
]
playbook_file       = "ubuntu/config/prep.yml"