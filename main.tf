terraform {
  required_version = ">= 0.12.0"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}

module "servers" {
  source = "./modules/vsphere-virtual-machines"

  vsphere_datacenter = var.vsphere_datacenter
  vsphere_datastore  = var.vsphere_datastore
  vsphere_cluster    = var.vsphere_cluster
  vm_template        = var.vm_template
  virtual_machines   = var.virtual_machines

  providers = {
    vsphere = "vsphere"
  }
}
