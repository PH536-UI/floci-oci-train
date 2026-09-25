terraform { required_providers { oci = { source = "oracle/oci" } } }
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  user_ocid = "ocid1.user.oc1..anyuser" fingerprint = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
  private_key_path = "/tmp/fake.pem" region = "us-ashburn-1"
}
variable "drg_id" { default = "ocid1.drg.oc1..flocilocal" }
variable "vcn_id" { default = "ocid1.vcn.oc1..flocilocal" }
resource "oci_core_drg_attachment" "vcn_attach" {
  drg_id = var.drg_id vcn_id = var.vcn_id display_name = "VCN-to-DRG"
}
resource "oci_core_remote_peering_connection" "rpc" {
  compartment_id = "ocid1.tenancy.oc1..flocilocaltenancy0000000000000000000000000000000000000000"
  drg_id = var.drg_id display_name = "RPC-to-OnPrem"
}
