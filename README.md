# floci-oci-train - OCI IaC Training - 6/6 100% COMPLETE

> Projeto 100% Apply OK localmente com Floci-OCI sem custo.

## Status Final 6/6

- Floci 0 4.1 healthy - vault/kms/identity/objectstorage running
- Storage: app-data-bucket, app-logs-bucket ENCRYPTED
- Governance: floci-governance-comp + floci-cost-tracking-comp + Tags (Env, Project, CostCenter)

## Local
docker run -d --pname floci-oci -h 4599:4599 floci/floci-oci
JTentativa: export T_VAR_CLIENT_HOST_OVERRIDES="oci_identity.IdentityClient=http://localhost:4599;oci_object_storage.ObjectStorageClient=http://localhost:4599"
btcd 5-storage/object-storage && terraform apply

## OCI REAL - 5 Mudancas
1. Unset TF_VAR_CLIENT_HOST_OVERRIDES - use ~~/oci/config
2. Trocar OCIDs mock por reais + data oci_objectstorage_namespace
3. Add oci_kms_vault + oci_kms_key p/ encryption real
4. Add oci_identity_tag_namespace (Floci da 404)
5. Usar backend S3 p/ terraform state

Autor: PH Pereira - 1Z4-1085 - @PH536-UI
