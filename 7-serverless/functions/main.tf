provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  user_ocid = "ocid1.user.oc1..anyuser"
  fingerprint = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
  private_key_path = "/tmp/fake.pem"
  region = "us-ashburn-1"
}

resource "oci_functions_application" "app" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  display_name = "floci-app"
  subnet_ids = ["ocid1.subnet.oc1..flocilocal"]
}

resource "oci_functions_function" "hello_fn" {
  application_id = oci_functions_application.app.id
  display_name = "hello-fn"
  image = "fnproject/fn-java-fdk:latest"
  memory_in_mbs = 128
}
