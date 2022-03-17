terraform {
  required_providers {
    proxmox = {
      source      = "telmate/proxmox"
      version     = ">=2.0.0"
    }
  }
}
provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url    = "https://10.125.128.44:8006/api2/json"
    pm_user       = "root@pam"
    pm_password   = "ghbdtn"
}

resource "proxmox_lxc" "lxc-test" {
    count         = 3
    hostname      = "k8s-node-${count.index}"
    cores         = 1
    memory        = "1024"
    swap          = "2048"
    network {
        name      = "enp5s0"
        bridge    = "vmbr0"
        ip        = "dhcp"
        firewall  = false
        hwaddr = "00:A0:B0:81:4${count.index + 7}:0${count.index + 2}"
    }

    ostemplate    = "local:vztmpl/core.tar.gz"
    password      = "ghbdtn"
    pool          = "k8s"

    rootfs {
    	storage     = "local-lvm"
	    size        = "8G"
    }
    ssh_public_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgL4U2a1dh9MO+AWGEsIATUMnQiV3jhmLcwZPRqitvBgfSJmGAf/+2v1j/Jk2QkG/z6vIDQQTZH+nQ9nhKGJhpo4Ns2+1qsOWxWgC3iPzFITl/1AlRGDCwXIhJrZ+8QjEup8dOarWQC4z7AgeE5rULtDXuKO/6VlAypQQp5ROf6E5wSR1RgxuF1bE5EdL2KmqdwsQHgDJa9ds6eel34yUS3OmFvp1O5wP/trNQ2PZ0mMA7HdJ2bvWt+HS5DaSiSD4sFwrEu4t9zNc12JfCLzWNsVd5ndXJiH7Y8VhBNT6GUZljKKpJtbjCu7OXRGxhD/JM5Yg92pDjQjALxWxUHuQbVWH8ZNgGEcfC/WwY4aVhLGsWGA7enSuiER+GaElaClwzMVyiAI6cXHIazE0rRM4WDExPsVrIAPrHJgh0Imeh6HJ7Gfu/wYSwWRUMSJF1o1tB2zzoAcm8W+Vx7SbI2fgkHn2QP+X8PUy/lmGnIx4SNKd2SezpWFmgPBBO8YRxmjM= root@nnltcar129-70"
    target_node   = "nnltcar128-44"
    unprivileged  = true
}