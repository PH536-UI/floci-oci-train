# VCN Security - Security List & Network Security Group
# Simulando Oracle Cloud - Floci-OCI 0.4.1 (validate only)

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  tenancy_ocid         = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  user_ocid            = "ocid1.user.oc1..anyuser"
  fingerprint          = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
  private_key_path     = "/tmp/fake.pem"
  region               = "us-ashburn-1"
}

# VCN referencia (já criada no lab anterior)
variable "vcn_id" {
  default = "ocid1.vcn.oc1..flocilocal"
}

# 1. Public Security List - permite 22, 80, 443 de qualquer lugar
resource "oci_core_security_list" "public_sl" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id         = var.vcn_id
  display_name   = "PublicSecurityList"

  # Ingress - SSH
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    description = "SSH from internet"

    tcp_options {
      min = 22
      max = 22
    }
  }

  # Ingress - HTTP
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "HTTP"

    tcp_options {
      min = 80
      max = 80
    }
  }

  # Ingress - HTTPS
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    description = "HTTPS"

    tcp_options {
      min = 443
      max = 443
    }
  }

  # Egress - permite tudo sair (0.0.0.0/0)
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    description = "Allow all outbound"
  }
}

# 2. Private Security List - só permite do VCN 10.0.0.0/16
resource "oci_core_security_list" "private_sl" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id         = var.vcn_id
  display_name   = "PrivateSecurityList"

  ingress_security_rules {
    protocol    = "all"
    source      = "10.0.0.0/16"
    description = "Allow all from VCN"
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}
