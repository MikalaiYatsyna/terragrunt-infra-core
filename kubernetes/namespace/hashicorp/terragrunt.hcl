include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/eks-ns/aws?version=0.0.2"}

dependency "cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  cluster_name   = dependency.cluster.outputs.cluster_name
  namespace_name = "hashicorp"
}
