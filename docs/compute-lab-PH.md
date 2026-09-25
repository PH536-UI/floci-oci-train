# Lab 3-compute - PH Pereira - 25/09/2025

## Vídeos assistidos
- Compute Introduction - 5m
- Demo: Launch and Connect to an Oracle Linux Instance - 15m

## O que foi criado
- Pasta 3-compute/main.tf
- Shape: VM.Standard.E4.Flex (1 OCPU, 16GB)
- Image: Oracle Linux 8
- AD: data.oci_identity_availability_domain.ad1
- SSH: ~/.ssh/id_rsa (2048) - SHA256:Yy+66o8ZOF8HVgq44h4fseETXStyQxEdozALWz65dy0

## Comandos
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N "" -C "ph@floci-oci-train"
terraform init
terraform validate -> Success!

## Status Floci
Floci NÃO implementa oci_core_instance - por isso só validate, sem apply local
Pronto pra conta REAL Free Tier

## Proximo Apply Real
terraform apply -var="compartment_ocid=OCID" -var="subnet_ocid=OCID"
ssh opc@<IP> -i ~/.ssh/id_rsa

Owner: ph@phpereira - PH Pereira
Tag: Floci-Train-PH
