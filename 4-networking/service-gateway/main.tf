terraform {
  required_providers {
    oci = { source = "oracle/oci" }
  }
}
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  user_ocid = "ocid1.user.oc1..anyuser"
  fingerprint = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
  private_key_path = "/tmp/fake.pem"
  region = "us-ashburn-1"
}
data "oci_core_services" "all" {}
resource "oci_core_service_gateway" "sgw" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  vcn_id = "ocid1.vcn.oc1..flocilocal"
  display_name = "ServiceGateway-ObjectStorage"
  services {
    service_id = data.oci_core_services.all.services[0].id
  }
}
