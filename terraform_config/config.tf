terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=1.0.0"
    }
  }
}
provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://10.125.128.44:8006/api2/json"
    pm_user = "root@pam"
    pm_password = "ghbdtn"
}

resource "proxmox_lxc" "lxc-test" {
    hostname = "lxc-test-host"
    cores = 1
    memory = "1024"
    swap = "2048"
    network {
        name = "eth0"
        bridge = "vmbr1"
        ip = "192.168.20.20/24"
        firewall = false
    }
    ostemplate = "local:vztmpl/rocky.tar.xz"
    password = "ghbdtn"
    pool = "k8s"
    rootfs {
    	storage = "local-lvm"
	size	= "8G"
    }
    target_node = "nnltcar128-44"
    unprivileged = true
}
