# Project: proxmox
# Created by: Praveen Premaratne
# Created on: 03/02/2025 20:31
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://${proxmox_port}:${proxmox_port}/api2/json"
}