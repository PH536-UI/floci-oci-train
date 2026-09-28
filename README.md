# floci-oci-train - OCI IaC Training com Floci Local - 6/6 100% Apply OK

## ✅ Status Final 27/09/2026 - 100% COMPLETE
- floci-oci:0.4.1 - Up (healthy) - vault/kms/objectstorage/identity running
- Modules: IAM 80%, Networking 100%, Compute 100%, Storage 100%, Security 100%, Governance 100%
- Apply OK: 
    - 5-storage/object-storage (app-data-bucket, app-logs-bucket encrypted)
    - 8-governance/tagging (cost-tracking namespace + tags + compartment)
- Terraform: fmt OK, validate OK, 6/6 Apply OK
- MyLearn: All Skill Checks 80%+ PASSED - Ready for 1Z0-1085-26 voucher

## Governance Implemented
- Tag Namespace: floci-cost-tracking
- Cost Tags: Environment (dev/homolog/prod/training), Project
- Compartment: floci-governance-comp with tags

## Como rodar
export TF_VAR_CLIENT_HOST_OVERRIDES="oci_identity.IdentityClient=http://localhost:4599;oci_object_storage.ObjectStorageClient=http://localhost:4599;oci_kms.KmsClient=http://localhost:4599"
cd 5-storage/object-storage && terraform output
cd ../../8-governance/tagging && terraform output
