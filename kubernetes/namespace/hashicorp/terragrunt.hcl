include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/namespace/kubernetes?version=0.0.4"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/aws/eks"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  namespace_name = "hashicorp"
  cluster_endpoint = dependency.cluster.outputs.cluster_endpoint
  cluster_ca       = dependency.cluster.outputs.cluster_ca
  k8s_exec_args    = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
  k8s_exec_command = include.root.locals.k8s_exec_command
}
