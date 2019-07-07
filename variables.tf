variable "vsphere_server" {
  description = "The hostname of the vSphere server."
}

variable "vsphere_user" {
  description = "The user to connect on the vSphere."
}

variable "vsphere_password" {
  description = "The user's password."
}

variable "vsphere_datacenter" {
  description = "The datacenter where the vm should be."
}

variable "vsphere_cluster" {
  description = "The cluster where the vm should be."
}

variable "vsphere_datastore" {
  description = "The datastore where the vm will be put."
}

variable "vsphere_allow_unverified_ssl" {
  description = "Precise if the vSphere server certificate should be verified."
}

variable "virtual_machines" {
  type        = list(any)
  description = "The list of virtual machines you wish to create."
}

variable "vm_template" {
  description = "The template the virtual machines should be based on."
}
