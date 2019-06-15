data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vms" {
  count = length(var.virtual_machines)

  name             = var.virtual_machines[count.index].name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  folder           = lookup(var.virtual_machines[count.index], "folder", null)

  num_cpus               = var.virtual_machines[count.index].cpus
  num_cores_per_socket   = var.virtual_machines[count.index].cpus
  cpu_hot_add_enabled    = lookup(var.virtual_machines[count.index], "hot_add_cpu", true)
  cpu_hot_remove_enabled = lookup(var.virtual_machines[count.index], "hot_remove_cpu", true)
  memory                 = var.virtual_machines[count.index].memory
  memory_hot_add_enabled = lookup(var.virtual_machines[count.index], "hot_add_memory", true)
  guest_id               = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  dynamic "disk" {
    for_each = var.virtual_machines[count.index].disks

    content {
      label            = disk.value.label
      size             = disk.value.size
      thin_provisioned = disk.value.thin_provisionned
      unit_number      = disk.key
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name         = var.virtual_machines[count.index].name
        admin_password        = var.virtual_machines[count.index].os_admin_password
        time_zone             = 90
        workgroup             = lookup(var.virtual_machines[count.index], "workgroup", null)
        join_domain           = lookup(var.virtual_machines[count.index], "domain", null)
        domain_admin_user     = lookup(var.virtual_machines[count.index], "domain_admin_user", null)
        domain_admin_password = lookup(var.virtual_machines[count.index], "domain_admin_password", null)

        auto_logon            = true
        run_once_command_list = ["shutdown /r /t 0"]
      }

      dynamic "network_interface" {
        for_each = var.virtual_machines[count.index].networks_interfaces

        content {
          ipv4_address    = lookup(network_interface.value, "ipv4_address", null)
          ipv4_netmask    = lookup(network_interface.value, "ipv4_netmask", null)
          dns_server_list = lookup(network_interface.value, "dns_servers", null)
          dns_domain      = lookup(network_interface.value, "dns_domain", null)
        }
      }

      ipv4_gateway = lookup(var.virtual_machines[count.index], "ipv4_gateway", "")
    }

  }
}
