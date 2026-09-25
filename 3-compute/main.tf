terraform {
  required_providers {
    oci = { source = "oracle/oci" }
  }
}

variable "compartment_ocid" {}
variable "subnet_ocid" {}
variable "ssh_public_key_path" { default = "~/.ssh/id_rsa.pub" }

data "oci_identity_availability_domain" "ad1" {
  compartment_id = var.compartment_ocid
  ad_number = 1
}

data "oci_core_images" "ol8" {
  compartment_id = var.compartment_ocid
  operating_system = "Oracle Linux"
  operating_system_version = "8"
  shape = "VM.Standard.E4.Flex"
  sort_by = "TIMECREATED"
  sort_order = "DESC"
}

resource "oci_core_instance" "app_instance_ph" {
  compartment_id = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domain.ad1.name
  shape = "VM.Standard.E4.Flex"
  shape_config {
    ocpus = 1
    memory_in_gbs = 16
  }
  display_name = "app-instance-ph-pereira"

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.ol8.images[0].id
  }

  create_vnic_details {
    subnet_id = var.subnet_ocid
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file(pathexpand(var.ssh_public_key_path))
  }
}

output "instance_public_ip" {
  value = oci_core_instance.app_instance_ph.public_ip
}
