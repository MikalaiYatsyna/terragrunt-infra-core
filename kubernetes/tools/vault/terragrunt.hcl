#locals {
#  vault_app_name = "vault"
#}
#
#include "root" {
#  path   = find_in_parent_folders()
#  expose = true
#}
#
#
#terraform {
#  source = "/Users/mikalai_yatsyna/IdeaProjects/Logistics/infra/aws/vault"
##  source = "tfr://app.terraform.io/logistic/vault/aws?version=0.0.10"
#}
#
#dependency "zone" {
#  config_path  = "${get_repo_root()}/network/zone"
#  skip_outputs = true
#}
#
#dependency "cluster" {
#  config_path = "${get_repo_root()}/kubernetes/cluster"
#}
#
#dependency "namespace" {
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
#dependency "external_dns" {
#  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
#  skip_outputs = true
#}
#
#inputs = {
#  stack              = include.root.locals.stack
#  namespace          = dependency.namespace.outputs.name
#  domain             = include.root.locals.domain
#  oidc_provider_arn  = dependency.cluster.outputs.oidc_provider_arn
#  vault_init_image   = "${include.root.locals.ecr_url}/vault-init:1.0.3"
#  certificate_issuer = dependency.cert_manager_issuer.outputs.letsencrypt_issuer
#  cluster_endpoint = dependency.cluster.outputs.cluster_endpoint
#  cluster_ca       = dependency.cluster.outputs.cluster_ca
#  k8s_exec_args    = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
#  k8s_exec_command = include.root.locals.k8s_exec_command
#}
