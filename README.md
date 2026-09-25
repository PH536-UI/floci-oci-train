# floci-oci-train - OCI IaC Training with Floci Local Emulator

Treinamento completo de Oracle Cloud Infrastructure usando Terraform + Floci-OCI (emulador local na porta 4599).
100% local, zero custo, pronto pra usar na conta real.

## 🚀 O que já aplica 100% no Floci Local (Apply OK)

| Lab | Serviço | Recurso | Status |
|---|---|---|---|
| 5-storage/object-storage | Object Storage | app-data-bucket + app-logs-bucket | Apply complete! |
| 5-storage/queue | Queue | app-tasks-queue | Apply complete! |
| 5-storage/streaming | Streaming | app-events-stream | Apply complete! |
| 6-security/vault | KMS Vault | app-vault | Apply complete! |
| 2-identity | Identity | Compartments | Apply complete! |

## ✅ O que valida local e aplica na Oracle Real

Esses serviços não são implementados no Floci (só validação), mas o MESMO código Terraform aplica na nuvem real:

- 4-networking/vcn, subnets, security-lists, DRG, Service Gateway, DNS
- 3-compute/load-balancer
- 7-serverless/functions (precisa de VCN real)

## Como rodar local

Inicia Floci: docker compose up -d
Export TF_VAR_CLIENT_HOST_OVERRIDES com endpoints http://localhost:4599
terraform init && terraform apply -auto-approve

## Como usar na conta REAL

unset TF_VAR_CLIENT_HOST_OVERRIDES e use ~/.oci/config real
