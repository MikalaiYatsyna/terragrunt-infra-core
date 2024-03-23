
# Introduction

This Terragrunt configuration automates the provisioning of core infrastructure resources. It sets up a Virtual Private
Cloud (VPC) network, deploys an Amazon Elastic Kubernetes Service (EKS) cluster within it, and configures all the
necessary tooling for managing and operating the cluster and its associated applications. The tooling includes
components such as Autoscaler, Ingress, Consul, Vault, Cert Manager, Grafana, and more.

# Input parameters

| Name                  | Description                                                                        |
|-----------------------|------------------------------------------------------------------------------------|
| platform              | Name of platform to be created.                                                    |
| root_domain           | Root domain name. Platform will have subdomain formed as {platform}.{root_domain}. |
| region                | AWS region to deploy to.                                                           |
| ecr_url               | URL of ECR Registry where docker & OCI images stored.                              |
| email                 | Email for cert-manager-issuer used for ACME.                                       |
| state_bucket_name     | S3 bucket where terraform state will be stored.                                    |
| state_lock_table_name | DynamoDB Table used for Terraform state locking.                                   |

# Technical ENV Variables

| Name | Description| 
|------|------------|
| CLOUDFLARE_API_TOKEN| CloudFlare API token to perform DNS delegation | 
| TG_TF_REGISTRY_TOKEN| Terrafrom Cloud Registry toke to pull terraform modules | 

# Summary of created resources

## Network

- [Cloudflare DNS](./cloudflare/dns/terragrunt.hcl)
- [VPC](aws/vpc/terragrunt.hcl)
- [Route 53 zone](aws/route53/terragrunt.hcl)

## Kubernetes

- [EKS Cluster](aws/eks/terragrunt.hcl)

### Namespaces

- [Argo](./kubernetes/namespace/argo/terragrunt.hcl)
- [Autoscaler](./kubernetes/namespace/autoscaler/terragrunt.hcl)
- [Cert Manager](./kubernetes/namespace/cert_manager/terragrunt.hcl)
- [External DNS](./kubernetes/namespace/external_dns/terragrunt.hcl)
- [HashiCorp](./kubernetes/namespace/hashicorp/terragrunt.hcl)
- [Ingress](./kubernetes/namespace/ingress/terragrunt.hcl)

### Tools

- [Argo CD](./kubernetes/tools/argo_cd/terragrunt.hcl)
- [Autoscaler](./kubernetes/tools/autoscaler/terragrunt.hcl)
- [Cert Manager](./kubernetes/tools/cert_manager/terragrunt.hcl)
- [Cert Manager Issuer](./kubernetes/tools/cert_manager_issuer/terragrunt.hcl)
- [Consul](./kubernetes/tools/consul/terragrunt.hcl)
- [External DNS](./kubernetes/tools/external_dns/terragrunt.hcl)
- [Ingress Controller](./kubernetes/tools/ingress/terragrunt.hcl)
- [Vault](./kubernetes/tools/vault/terragrunt.hcl)
- Vault Config
  - [K8s Auth](./kubernetes/tools/vault_config/k8s-auth/terragrunt.hcl)
  - [Secret Backends](./kubernetes/tools/vault_config/secret_backends/terragrunt.hcl)