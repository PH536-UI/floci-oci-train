# Load Balancer - Public LB + Backend Set + Listener 80/443
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

variable "vcn_id" { default = "ocid1.vcn.oc1..flocilocal" }
variable "subnet_ids" { default = ["ocid1.subnet.oc1..flocilocal1", "ocid1.subnet.oc1..flocilocal2"] }

# 1. Load Balancer Public
resource "oci_load_balancer_load_balancer" "public_lb" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  display_name   = "PublicLoadBalancer"
  shape          = "flexible"
  subnet_ids     = var.subnet_ids

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 100
  }
}

# 2. Backend Set - porta 80
resource "oci_load_balancer_backend_set" "web_bset" {
  load_balancer_id = oci_load_balancer_load_balancer.public_lb.id
  name             = "web-backend-set"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol = "HTTP"
    port     = 80
    url_path = "/"
  }
}

# 3. Listener - HTTP 80 -> Backend
resource "oci_load_balancer_listener" "http_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.public_lb.id
  name                     = "http-listener"
  default_backend_set_name = oci_load_balancer_backend_set.web_bset.name
  port                     = 80
  protocol                 = "HTTP"
}
