# O que é? / What is?
# Lab VCN Routing - Simulando Oracle Cloud 100% local com Floci-OCI
# Public Route: 0.0.0.0/0 -> Internet Gateway
# Private Route: 0.0.0.0/0 -> NAT Gateway + 192.168.0.0/16 -> DRG

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# Provider apontando pro seu Floci local na porta 4599
provider "oci" {
  tenancy_ocid         = "ocid1.tenancy.oc1..fake"
  user_ocid            = "ocid1.user.oc1..fake"
  fingerprint          = "60:45:7b:73:45:7f:f5:98:ba:b5:c7:bd:9f:08:89:45"
  private_key_path     = "/tmp/fake.pem"
  region               = "us-ashburn-1"
}

# 1. VCN 10.0.0.0/16
resource "oci_core_vcn" "demovcnwizard" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  cidr_block     = "10.0.0.0/16"
  display_name   = "demovcnwizard"
  dns_label      = "demovcn"
}

# 2. Internet Gateway - para rota publica
resource "oci_core_internet_gateway" "igw" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id         = oci_core_vcn.demovcnwizard.id
  display_name   = "InternetGateway"
  enabled        = true
}

# 3. NAT Gateway - para rota privada 0.0.0.0/0
resource "oci_core_nat_gateway" "natgw" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id         = oci_core_vcn.demovcnwizard.id
  display_name   = "NATGateway"
}

# 4. DRG - para rota 192.168.0.0/16 -> On-Premises
resource "oci_core_drg" "drg" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  display_name   = "DRG-to-OnPrem"
}

# 5. Public Route Table - 0.0.0.0/0 -> IGW
resource "oci_core_route_table" "public_rt" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id         = oci_core_vcn.demovcnwizard.id
  display_name   = "PublicRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

# 6. Private Route Table - 0.0.0.0/0 -> NAT + 192.168.0.0/16 -> DRG
resource "oci_core_route_table" "private_rt" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id         = oci_core_vcn.demovcnwizard.id
  display_name   = "PrivateRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.natgw.id
  }

  route_rules {
    destination       = "192.168.0.0/16"
    network_entity_id = oci_core_drg.drg.id
  }
}
