variable "vsphere_datacenter" {
  description = "The datacenter where the virtual machines will be put."
}

variable "vsphere_cluster" {
  description = "The cluster where the virtual machines will be put."
}

variable "vsphere_datastore" {
  description = "The datastore where the virtual machines will be put."
}

variable "virtual_machines" {
  type        = list(any)
  description = "The list of virtual machines you wish to create."

}

variable "vm_template" {
  description = "The template the virtual machines should be based on."
}
