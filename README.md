# Terraform Proxmox LXC Module
Terraform module for provisioning LXC infrastructure on Proxmox

## Usage example
```hcl

# Configure the Proxmox server endpoint
provider "proxmox" {
  pm_api_url = "https://proxmox.example.com:8006/api2/json"
}

module "container" {
  source = "git::ssh://git@github.com:razorcorp/terraform-proxmox-lxc-module.git"

  proxmox_host = "orion.razorcorp.dev"
  datacenter   = "dc1"
  image        = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  hostname     = "sandbox"
  public_key   = "ssh-rsa AAAAB3N...."

  resources = {
    cpu    = 1
    memory = 4096
    swap   = 1024
  }

  disk = {
    size_gb = 50
    storage = "local-zfs"
  }

  networking = {
    bridge  = "vmbr0"
    ip_addr = "10.0.0.5"
    cidr    = 24
    gateway = "10.0.0.1"
  }

  tags = [
    "test"
  ]
}
```

## Module Variables

### Requirements

| Name              | Version       |
| ----------------- | ------------- |
| Terraform         | >= 0.13       |
| Telmate/proxmox   | >= 3.0.1-rc4  |

### Providers

| Name              | Version       |
| ----------------- | ------------- |
| Telmate/proxmox   | >= 3.0.1-rc4  |

### Inputs

| Name              | Required | Description | Type | Default |
| ----------------- | -------- | ----------- | ---- | ------- |
| `datacenter`      | Yes      | Proxmox datacenter name | `string` | N/A |
| `image`           | No       | OS temlate path for root fs extraction | `string` | `local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz` |
| `hostname`        | Yes      | Container hostname | `string` | N/A |
| `resources`       | No       | Container resource configuration | <pre>object({<br>  cpu    = number<br>  memory = number<br>  swap   = number<br>})</pre> | <pre>{<br>   cpu = 1<br>   memory = 1024<br>   swap   = 512<br>}</pre> |
| `public_key`      | Yes      | SSH public key include in the container | `string` | N/A |
| `disk`            | Yes      | Root disk options | <pre>object({<br>  size_gb = number<br>  storage = string<br>})</pre> | N/A |
| `networking`      | Yes      | Container network configuration | <pre>object({<br>  bridge  = string<br>  ip_addr = string<br>  cidr    = number<br>  gateway = string<br>})</pre> | N/A |
| `nameservers`     | No       | List of upstream DNS servers to use | `list(string)` | `["1.1.1.1", "8.8.8.8"]` |
| `options`         | No       | Container option flags | <pre>object({<br>  onboot       = bool<br>  start        = bool<br>  unprivileged = bool<br>  nesting      = bool<br>})</pre> |<pre>{<br>  onboot       = true<br>  start        = true<br>  unprivileged = false<br>  nesting      = false<br>}</pre> |
| `tags`            | No       | List of tag to tag the container | `list(string)`| `[]`|