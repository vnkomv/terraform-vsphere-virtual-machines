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
  vsphere_server       = vsphere.exemple.com
  allow_unverified_ssl = true
}


module "servers" {
  source  = "vnkomv/virtual-machines/vsphere"
  version = "0.0.3"

  vsphere_datacenter = "DC-01"
  vsphere_datastore  = "DSTORE-01"
  vsphere_cluster    = "CLU-001"
  vm_template        = "windows-server2016-template"
  virtual_machines   = var.virtual_machines

  providers = {
    vsphere = "vsphere"
  }
}

```

## INPUTS

| NAME               | TYPE   | DESCRIPTION                                                |
| ------------------ | ------ | ---------------------------------------------------------- |
| vsphere_datacenter | string | The datacenter where the virtual machines will be put.     |
| vsphere_cluster    | string | The cluster where the virtual machines will be put.        |
| vsphere_datastore  | string | The datastore where the virtual machines will be put.      |
| vm_template        | string | The template the virtual machines should be based on.      |
| virtual_machines   | objet  | The parameters of the virtual machines you wish to create. |

## OUTPUS

| NAME           | DESCRIPTION                                                         |
| -------------- | ------------------------------------------------------------------- |
| instances_ips  | The default ips of the created machines identified by their name.   |
| instances_ids  | The vSphere's ids of the created machines identified by their name. |
| instance_names | Return the ids the created virtual machines.                        |
