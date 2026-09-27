provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  user_ocid = "ocid1.user.oc1..anyuser"
  fingerprint = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
  private_key_path = "/tmp/fake.pem"
  region = "us-ashburn-1"
}

resource "oci_objectstorage_bucket" "demo" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  namespace = "floci-local"
  name = "app-data-bucket"
}

resource "oci_objectstorage_bucket" "logs" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  namespace = "floci-local"
  name = "app-logs-bucket"
}
