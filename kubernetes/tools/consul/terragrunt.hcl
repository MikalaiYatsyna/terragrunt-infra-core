#include "root" {
#  path   = find_in_parent_folders()
#  expose = true
#}
#
#terraform {
#  source = "/Users/mikalai_yatsyna/IdeaProjects/Logistics/infra/aws/consul"
##  source = "tfr://app.terraform.io/logistic/consul/aws?version=0.0.10"
#}
#
#dependency "external_dns" {
#  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
#  skip_outputs = true
#}
#
#dependency "cluster" {
#  config_path = "${get_repo_root()}/aws/eks"
#}
#
#dependency "hashicorp_namespace" {
#  config_path = "${get_repo_root()}/kubernetes/namespace/hashicorp"
#}
#
#dependency "ingress" {
#  config_path  = "${get_repo_root()}/kubernetes/tools/ingress"
#  skip_outputs = true
#}
#
#dependency "cert_manager_issuer" {
#  config_path = "${get_repo_root()}/kubernetes/tools/cert_manager_issuer"
#}
#
#dependency "vault" {
#  config_path = "${get_repo_root()}/kubernetes/tools/vault"
#}
#
#dependency "vault_secret_backends" {
#  config_path = "${get_repo_root()}/kubernetes/tools/vault_config/secret_backends"
#}
#
#dependency "vault_k8s_auth" {
#  config_path = "${get_repo_root()}/kubernetes/tools/vault_config/k8s-auth"
#}
#
#dependency "external_dns" {
#  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
#  skip_outputs = true
#}
#
#inputs = {
#  stack                    = include.root.locals.stack
#  namespace                = dependency.hashicorp_namespace.outputs.name
#  domain                   = include.root.locals.domain
#  oidc_provider_arn        = dependency.cluster.outputs.oidc_provider_arn
#  certificate_issuer       = dependency.cert_manager_issuer.outputs.letsencrypt_issuer
#  vault_address            = dependency.vault.outputs.vault_address
#  vault_token_secret_id    = dependency.vault.outputs.vault_token_secret_id
#  vault_k8s_path           = dependency.vault_k8s_auth.outputs.backend_path
#  vault_server_cert_secret = dependency.vault.outputs.vault_server_cert_secret_name
#  pki_backend              = dependency.vault_secret_backends.outputs.backend["pki"]
#  kv_backend               = dependency.vault_secret_backends.outputs.backend["kv-v2"]
#  cluster_endpoint = dependency.cluster.outputs.cluster_endpoint
#  cluster_ca       = dependency.cluster.outputs.cluster_ca
#  k8s_exec_args    = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
#  k8s_exec_command = include.root.locals.k8s_exec_command
#}
