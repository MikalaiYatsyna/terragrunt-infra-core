include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/argo-cd/aws?version=0.0.1"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "cert_manager_issuer" {
  config_path = "${get_repo_root()}/kubernetes/tools/cert_manager_issuer"
}

dependency "external_dns" {
  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
  skip_outputs = true
}

dependency "argo_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/argo"
}

inputs = {
  cluster_name       = dependency.cluster.outputs.cluster_name
  certificate_issuer = dependency.cert_manager_issuer.outputs.letsencrypt_issuer
  domain             = include.root.locals.domain
  namespace          = dependency.argo_namespace.outputs.name
}
