terraform { required_providers { oci = { source = "oracle/oci" } } }
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  user_ocid = "ocid1.user.oc1..anyuser" fingerprint = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
  private_key_path = "/tmp/fake.pem" region = "us-ashburn-1"
}
resource "oci_dns_zone" "public_zone" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  name = "floci.local" zone_type = "PRIMARY"
}
