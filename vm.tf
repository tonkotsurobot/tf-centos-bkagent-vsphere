terraform {
  backend "local" {
    path = "/mnt/tf-centos-bkagent-vsphere/terraform.tfstate"
  }
}

resource "vsphere_virtual_machine" "vm" {
  name             = "${var.vm_name}-${count.index + 1}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  count            = var.vmcount
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.vm_name}-${count.index + 1}"
        domain    = "home"
      }

      network_interface {}

      dns_server_list = ["192.168.1.20"]
      dns_suffix_list = ["home"]
    }
  }

}


