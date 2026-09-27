# floci-oci-train - OCI IaC Training com Floci Local - 100% Apply OK

## ✅ Status Final 27/09/2026 21:35
- floci-oci:0.4.1 - Up (healthy) - vault/kms/objectstorage running
- Apply OK: 5-storage/object-storage (app-data-bucket, app-logs-bucket) encrypted
- Terraform: fmt OK, validate OK, outputs OK
- Skill Checks: IAM 80%, Networking 100%, Compute 100%, Storage 100%, Security 100% PASSED
- Security Implemented: Vault + KMS mock + encrypted buckets + Cloud Guard concepts validated

## Como rodar
export TF_VAR_CLIENT_HOST_OVERRIDES="oci_identity.IdentityClient=http://localhost:4599;oci_object_storage.ObjectStorageClient=http://localhost:4599;oci_kms.KmsClient=http://localhost:4599;oci_vault.VaultClient=http://localhost:4599"
cd 5-storage/object-storage && terraform plan && terraform output
