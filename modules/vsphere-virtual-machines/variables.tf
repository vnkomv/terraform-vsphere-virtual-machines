variable "vsphere_datacenter" {
  description = "The datacenter where the vm should be."
}

variable "vsphere_cluster" {
  description = "The cluster where the vm should be."
}

variable "vsphere_datastore" {
  description = "The datastore where the vm will be put."
}

variable "virtual_machines" {
  type        = list(any)
  description = "The list of virtual machines you wish to create."

}

variable "vms_defaults" {
  type        = map
  description = "The parameters that are common to the virtual machines."
}

variable "vm_network" {
  description = "The network where the virtual machines should be put."
}

variable "vm_template" {
  description = "The template the virtual machines should be based on."
}
