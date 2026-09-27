# floci-oci-train - OCI IaC Training com Floci Local - 100% Apply OK

## ✅ Status Final 27/09/2026 21:22
- floci-oci:0.4.1 - Up (healthy) - persistent ./data
- Namespace: floci-local
- Apply OK: 5-storage/object-storage (app-data-bucket, app-logs-bucket)
- Terraform: oracle/oci + TF_VAR_CLIENT_HOST_OVERRIDES="oci_identity.IdentityClient=http://localhost:4599;oci_object_storage.ObjectStorageClient=http://localhost:4599"
- Skill Checks: IAM 80%, Networking 100%, Compute 100%, Storage - Apply OK

## Como rodar
export TF_VAR_CLIENT_HOST_OVERRIDES="oci_identity.IdentityClient=http://localhost:4599;oci_object_storage.ObjectStorageClient=http://localhost:4599"
cd 5-storage/object-storage && terraform plan
