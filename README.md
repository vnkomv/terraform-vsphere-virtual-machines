# terraform-vsphere-virtual-machines

A Terraform module for creating multiple windows virtual machines on VMWare vSphere from a base template.

The module needs a the terraform vSphere provider to be passed on him to function. You can configure one by following the instructions [here](https://www.terraform.io/docs/providers/vsphere/index.html).

The following ressources are also used:

- [`vsphere_virtual_machine` (Data Source)](https://www.terraform.io/docs/providers/vsphere/d/virtual_machine.html)
- [`vsphere_datacenter`](https://www.terraform.io/docs/providers/vsphere/d/datacenter.html)
- [`vsphere_datastore`](https://www.terraform.io/docs/providers/vsphere/d/datastore.html)
- [`vsphere_virtual_machine`](https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html)

Example:

```hcl2

provider "vsphere" {
  user                 = "vsphere\\Administrator"
  password             = "Secret"
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}


module "servers" {
  source  = "vnkomv/virtual-machines/vsphere"
  version = "0.0.2"

  vsphere_datacenter = var.vsphere_datacenter
  vsphere_datastore  = var.vsphere_datastore
  vsphere_cluster    = var.vsphere_cluster
  vm_template        = var.vm_template
  virtual_machines   = var.virtual_machines

  providers = {
    vsphere = "vsphere"
  }
}

```
