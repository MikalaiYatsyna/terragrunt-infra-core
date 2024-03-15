include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/eks-autoscaler/aws?version=0.0.1"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "autoscaler_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/autoscaler"
}

inputs = {
  cluster_name                     = dependency.cluster.outputs.cluster_name
  cluster_identity_oidc_issuer     = dependency.cluster.outputs.oidc_provider
  cluster_identity_oidc_issuer_arn = dependency.cluster.outputs.oidc_provider_arn
  namespace                        = dependency.autoscaler_namespace.outputs.name
}
