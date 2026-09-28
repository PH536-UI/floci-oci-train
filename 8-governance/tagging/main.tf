# Governance - Tagging + Cost Tracking - Floci Local Mock
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

# 1. Tag Namespace - é o que organiza custos por projeto/ambiente
resource "oci_identity_tag_namespace" "cost_tracking" {
  compartment_id = var.tenancy_ocid
  name           = "floci-cost-tracking"
  description    = "Tag namespace for cost governance - Training"

  # Free tier tags desabilitados pra mock
  is_retired = false
}

# 2. Tag Definitions - as tags que você usaria pra billing
resource "oci_identity_tag" "environment" {
  tag_namespace_id = oci_identity_tag_namespace.cost_tracking.id
  name             = "Environment"
  description      = "Environment tag for cost allocation"
  is_retired       = false

  validator {
    validator_type = "ENUM"
    values         = ["dev", "homolog", "prod", "training"]
  }

  is_cost_tracking = true
}

resource "oci_identity_tag" "project" {
  tag_namespace_id = oci_identity_tag_namespace.cost_tracking.id
  name             = "Project"
  description      = "Project name for governance"
  is_retired       = false

  validator {
    validator_type = "DEFAULT"
  }

  is_cost_tracking = true
}

# 3. Compartment com tags - boa prática de Governance
resource "oci_identity_compartment" "governance_compartment" {
  compartment_id = var.tenancy_ocid
  name           = "floci-governance-comp"
  description    = "Compartment for governance training - with tags"

  freeform_tags = {
    "Environment" = "training"
    "Project"     = "floci-oci-train"
  }

  enable_delete = true
}

output "tag_namespace" {
  value = oci_identity_tag_namespace.cost_tracking.name
}

output "governance_compartment_id" {
  value = oci_identity_compartment.governance_compartment.id
}

output "cost_tags" {
  value = [
    oci_identity_tag.environment.name,
    oci_identity_tag.project.name
  ]
}

output "governance_status" {
  value = "Governance 100% - Tagging + Cost Tracking + Compartment implemented on floci-local"
}
