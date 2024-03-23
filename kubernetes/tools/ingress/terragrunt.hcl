include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/eks-ingress/aws?version=0.0.13"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "ingress_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/ingress"
}

inputs = {
  stack             = include.root.locals.stack
  cluster_name      = dependency.cluster.outputs.cluster_name
  namespace         = dependency.ingress_namespace.outputs.name
  oidc_provider_arn = dependency.cluster.outputs.oidc_provider_arn
}
