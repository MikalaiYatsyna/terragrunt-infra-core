include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/eks-autoscaler/aws?version=0.0.3"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/aws/eks"
}

dependency "namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/autoscaler"
}

inputs = {
  namespace                        = dependency.namespace.outputs.name
  cluster_name                     = dependency.cluster.outputs.cluster_name
  cluster_identity_oidc_issuer     = dependency.cluster.outputs.oidc_provide_url
  cluster_identity_oidc_issuer_arn = dependency.cluster.outputs.oidc_provider_arn
  cluster_endpoint                 = dependency.cluster.outputs.cluster_endpoint
  cluster_ca                       = dependency.cluster.outputs.cluster_ca
  k8s_exec_args                    = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
  k8s_exec_command                 = include.root.locals.k8s_exec_command
}
