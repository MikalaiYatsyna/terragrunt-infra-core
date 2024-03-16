include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/cert-manager-issuer/aws?version=0.0.7"
}


dependency "kubernetes_cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "cert_manager_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/cert_manager"
}

dependency "cert_manager" {
  config_path  = "${get_repo_root()}/kubernetes/tools/cert_manager"
  skip_outputs = true
}

inputs = {
  stack        = include.root.locals.stack
  cluster_name = dependency.kubernetes_cluster.outputs.cluster_name
  domain       = include.root.locals.domain
  region       = include.root.locals.region
  email        = include.root.locals.email
  namespace    = dependency.cert_manager_namespace.outputs.name
}
