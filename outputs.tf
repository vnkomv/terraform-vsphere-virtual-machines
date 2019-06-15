output "instances_ips" {
  description = "Return the default ips of the created vritual machines."
  value       = zipmap(vsphere_virtual_machine.vms.*.name, vsphere_virtual_machine.vms.*.default_ip_address)
}

output "instances_ids" {
  description = "Return the ids the created vritual machines."
  value       = zipmap(vsphere_virtual_machine.vms.*.name, vsphere_virtual_machine.vms.*.id)
}

output "instance_names" {
  description = "Return the ids the created virtual machines."
  value       = vsphere_virtual_machine.vms.*.name
}
