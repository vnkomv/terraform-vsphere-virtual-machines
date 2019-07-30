output "instances_ips" {
  description = "The default ips of the created machines identified by their name."
  value       = zipmap(vsphere_virtual_machine.vms.*.name, vsphere_virtual_machine.vms.*.default_ip_address)
}

output "instances_ids" {
  description = "The vSphere's ids of the created machines identified by their name."
  value       = zipmap(vsphere_virtual_machine.vms.*.name, vsphere_virtual_machine.vms.*.id)
}

output "instance_names" {
  description = "Return the ids the created virtual machines."
  value       = vsphere_virtual_machine.vms.*.name
}
