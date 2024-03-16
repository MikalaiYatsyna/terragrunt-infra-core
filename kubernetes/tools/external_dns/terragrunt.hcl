include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/external-dns/aws?version=0.0.3"
}

dependency "kubernetes_cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "zone" {
  config_path = "${get_repo_root()}/network/zone"
}

dependency "external_dns_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/external_dns"
}

inputs = {
  stack             = include.root.locals.stack
  cluster_name      = dependency.kubernetes_cluster.outputs.cluster_name
  domain            = include.root.locals.domain
  namespace         = dependency.external_dns_namespace.outputs.name
  oidc_provider_arn = dependency.kubernetes_cluster.outputs.oidc_provider_arn
}
