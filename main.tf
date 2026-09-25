variable "tenancy_ocid" { default = "ocid1.tenancy.oc1..FAKE_TENANCY_PH_PEREIRA" }

# Identidade do dono do lab - VOCÊ
locals {
  owner = "ph@phpereira - PH Pereira"
  tag   = "Floci-Train-PH"
}

# DEMO 1: Managing Groups - com seu nome
resource "null_resource" "demo_groups" {
  for_each = {
    "OCI-admin-group-PH" = "Grupo de Admins do PH Pereira - day-to-day operations"
    "Network-Admins-PH"  = "Grupo de Rede do PH - gerencia VCN"
    "Storage-Admins-PH"  = "Grupo de Storage do PH - gerencia buckets"
  }
  triggers = { 
    group_name = each.key
    description = each.value
    owner = local.owner
  }
  provisioner "local-exec" {
    command = "echo '✅ [Groups - PH] ${self.triggers.group_name} | ${self.triggers.description} | Owner: ${self.triggers.owner}' | tee -a VITORIA.txt"
  }
}

# DEMO 2: Managing Users - com seu nome
resource "null_resource" "demo_users" {
  for_each = {
    "ph.pereira.admin" = "PH Pereira - OCI Admin (não é Tenancy Admin)"
    "ph.pereira.net"   = "PH Pereira - Network Admin"
  }
  triggers = {
    user_name = each.key
    desc = each.value
    best_practice = "Enforce MFA - PH"
  }
  provisioner "local-exec" {
    command = "echo '✅ [Users - PH] ${self.triggers.user_name} | ${self.triggers.desc} | ${self.triggers.best_practice}' | tee -a VITORIA.txt"
  }
}

# DEMO 3: Admin Role
resource "local_file" "admin_role_PH" {
  filename = "./admin-role-PH.json"
  content = jsonencode({
    owner = local.owner
    best_practices = [
      "Best practice: Don't Use the Tenancy Administrator Account for Day-to-Day Operations - PH",
      "Best practice: Create dedicated compartments to isolate resources - PH Pereira Lab",
      "Best practice: Enforce MFA - PH"
    ]
    Tenancy_Admin = "ph@phpereira - NÃO USAR no dia a dia"
    OCI_Admin = "ph.pereira.admin - Usar no dia a dia - Owner PH"
  })
}

# DEMO 4: Policies - com seu nome nas policies
resource "local_file" "policies_PH" {
  filename = "./policies-PH.json"
  content = jsonencode({
    owner = local.owner
    compartment = "sandbox-compartment-PH-Pereira"
    policies = [
      "Allow group OCI-admin-group-PH to manage all-resources in compartment sandbox-compartment-PH-Pereira -- Policy do PH",
      "Allow group Network-Admins-PH to manage virtual-network-family in compartment sandbox-compartment-PH-Pereira -- Rede do PH",
      "Allow group Storage-Admins-PH to manage object-family in compartment sandbox-compartment-PH-Pereira -- Storage do PH"
    ]
  })
}

# DEMO 5: Tenancy Setup - Fluxo da sua imagem com seu nome
resource "null_resource" "tenancy_setup_PH" {
  triggers = {
    flow = "Tenancy Admin (PH) -> OCI Admin (ph.pereira.admin) -> OCI-admin-group-PH -> Policies-PH -> sandbox-compartment-PH-Pereira"
    fingerprint = "60:45:7b:73:45:7f:f5:98:ba:b5:c7:bd:9f:08:89:45"
    owner = local.owner
  }
  provisioner "local-exec" {
    command = "echo '✅ [Tenancy Setup - PH] Fluxo: ${self.triggers.flow} | FP: ${self.triggers.fingerprint}' | tee -a VITORIA.txt"
  }
  depends_on = [null_resource.demo_groups, local_file.policies_PH]
}

output "lab_PH" {
  value = "🎯 Lab 100% FAKE do PH Pereira completo! Owner: ${local.owner}"
}
