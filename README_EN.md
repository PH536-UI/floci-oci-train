# floci-oci-train - OCI IaC Training - 6/6 100% COMPLETE

> 100% Terraform Apply OK locally with Floci-OCI - zero OCI cost. Simulates real Oracle Cloud services: Vault, KMS, Object Storage, IAM Compartments, Tagging & Cost Governance.

## Final Status 6/6 - 2026-09-27

- Floci 0.4.1 healthy - vault/kms/identity/objectstorage running
- Storage: app-data-bucket, app-logs-bucket ENCRYPTED
- Governance: floci-governance-comp + floci-cost-tracking-comp + Tags (Env, Project, CostCenter)

## Local Setup
0``bash
docker run -d --name floci-oci -p 4599:4599 floci/floci-oci:latest
curl -s  http://localhost:4599/health | jq
export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..flocilocaltenancy0000"
export TF_VAR_CLIENT_HOST_OVERRIDES="oci_identity.IdentityClient=http://localhost:4599;oci_object_storage.ObjectStorageClient=http://localhost:4599"
htcd 5-storage/object-storage && terraform apply --auto-approve
```

## 5 Mandatory Changes for REAL OCI

**1. Remove Mocks** - unset TF_VAR_CLIENT_HOST_OVERRIDES
Bohes(**2. Real Auth** - ~~/oci/config with user/fingerprint/tenancy/region

**3. Real OCIDs+**
dbdata oci_objectstorage_namespace {}
resource oci_objectstorage_bucket { namespace = data.ns.namespace   // REAL namespace
kms_key_id = oci_kms_key.bucket_key.id }

-**4. Real Vault/KMS**
resource oci_kms_vault { display_name = "floci-vault-prod" }
resource oci_kms_key { algorithm = "AES" length = 256 }

-**5. Real Tag Namespace** (Floci got 404 / tagNamespaces)
resource oci_identity_tag_namespace { name = "cost-tracking" }
resource oci_identity_tag { is_cost_tracking = true }

## Proof for Recruiters
- docker ps -> floci healthy
- terraform output -> buckets + compartments
- curl /health -> vault/kms running
- Readme explains LOCAL -> PROD migration

Repo: github.com/PH536-UI/floci-oci-train
Author: PH Pereira - OCI 1Z0-1085-26 Ready