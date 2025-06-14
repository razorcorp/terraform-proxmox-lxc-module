resource "proxmox_lxc" "lxc" {
  target_node = var.datacenter
  onboot      = var.options.onboot
  start       = var.options.start
  ostemplate  = var.image

  hostname        = var.hostname
  unprivileged    = var.options.unprivileged
  cores           = var.resources.cpu
  memory          = var.resources.memory
  swap            = var.resources.swap
  ssh_public_keys = var.public_key

  features {
    nesting = var.options.nesting
  }

  rootfs {
    size    = "${var.disk.size_gb}G"
    storage = var.disk.storage
  }

  network {
    name   = "eth0"
    bridge = var.networking.bridge
    ip     = "${var.networking.ip_addr}/${var.networking.cidr}"
    gw     = var.networking.gateway
  }
  nameserver = join(" ", var.nameservers)

  tags = length(var.tags) > 0 ? join(";", var.tags) : ""

}