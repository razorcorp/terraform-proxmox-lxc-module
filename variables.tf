variable "datacenter" {
  type        = string
  description = "Proxmox datacenter name"
}

variable "image" {
  type        = string
  description = "OS temlate path for root fs extraction"
  default     = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
}

variable "hostname" {
  type        = string
  description = "Container hostname"
}

variable "resources" {
  type = object({
    cpu    = number
    memory = number
    swap   = number
  })
  description = "Container resource configuration"
  default = {
    cpu    = 1
    memory = 1024
    swap   = 512
  }
}

variable "public_key" {
  type        = string
  description = "SSH public key include in the container"
}

variable "disk" {
  type = object({
    size_gb = number
    storage = string
  })
  description = "Root disk options"
}

variable "networking" {
  type = object({
    bridge  = string
    ip_addr = string
    cidr    = number
    gateway = string
  })
  description = "Container network configuration"
}

variable "nameservers" {
  type        = list(string)
  description = "List of upstream DNS servers to use"
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "options" {
  type = object({
    onboot       = bool
    start        = bool
    unprivileged = bool
    nesting      = bool
  })
  description = "Container option flags"
  default = {
    onboot       = true
    start        = true
    unprivileged = false
    nesting      = false
  }
}

variable "tags" {
  type        = list(string)
  description = "List of tag to tag the container"
  default     = []
}