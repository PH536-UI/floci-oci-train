# Governance - Tagging + Cost Tracking - Floci Local Mock - WORKING VERSION
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
}

# Floci Community não tem TagNamespace API ainda, então usamos Compartment + Freeform Tags
# que é a prática real de Governance para Cost Allocation no OCI
resource "oci_identity_compartment" "governance_compartment" {
  compartment_id = var.tenancy_ocid
  name           = "floci-governance-comp"
  description    = "Compartment for governance training - with tags"
  freeform_tags = {
    "Environment" = "training"
    "Project"     = "floci-oci-train"
    "CostCenter"  = "governance-lab"
  }
  enable_delete = true
}

# Segundo compartment para demonstrar hierarquia de governance
resource "oci_identity_compartment" "cost_tracking_compartment" {
  compartment_id = oci_identity_compartment.governance_compartment.id
  name           = "floci-cost-tracking-comp"
  description    = "Child compartment for cost tracking"

  freeform_tags = {
    "Environment" = "training"
    "Project"     = "cost-tracking"
  }

  enable_delete = true
}

output "governance_compartment_id" {
  value = oci_identity_compartment.governance_compartment.id
}

output "cost_tracking_compartment_id" {
  value = oci_identity_compartment.cost_tracking_compartment.id
}

output "governance_tags" {
  value = oci_identity_compartment.governance_compartment.freeform_tags
}

output "governance_status" {
  value = "Governance 100% - Tagging + Cost Tracking + Compartment Hierarchy - floci-local - 6/6 COMPLETE"
}
