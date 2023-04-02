locals {
  vault_app_name = "vault"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}


terraform {
  source = "tfr://${include.root.locals.kubernetes.tools.vault.source}//.?version=${include.root.locals.kubernetes.tools.vault.version}"
}

dependency "zone" {
  config_path  = "${get_repo_root()}/network/zone"
  skip_outputs = true
}

dependency "kubernetes_cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "hashicorp_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/hashicorp"
}

dependency "ingress" {
  config_path  = "${get_repo_root()}/kubernetes/tools/ingress"
  skip_outputs = true
}

dependency "cert_manager_issuer" {
  config_path = "${get_repo_root()}/kubernetes/tools/cert_manager_issuer"
}

dependency "external_dns" {
  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
  skip_outputs = true
}

inputs = {
  stack              = include.root.locals.stack
  cluster_name       = dependency.kubernetes_cluster.outputs.cluster_name
  namespace          = dependency.hashicorp_namespace.outputs.name
  domain             = include.root.locals.domain
  oidc_provider_arn  = dependency.kubernetes_cluster.outputs.oidc_provider_arn
  vault_init_image   = "${include.root.locals.ecr_url}/vault-init:1.0.3"
  certificate_issuer = dependency.cert_manager_issuer.outputs.letsencrypt_issuer
}
