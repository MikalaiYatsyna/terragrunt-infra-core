include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/external-dns/kubernetes?version=0.0.4"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/aws/eks"
}

dependency "namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/external_dns"
}

dependency "iam_role" {
  config_path = "${get_repo_root()}/aws/iam/external-dns-role"
}

inputs = {
  namespace            = dependency.namespace.outputs.name
  cluster_endpoint     = dependency.cluster.outputs.cluster_endpoint
  cluster_ca           = dependency.cluster.outputs.cluster_ca
  k8s_exec_args        = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
  k8s_exec_command     = include.root.locals.k8s_exec_command
  iam_role_arn         = dependency.iam_role.outputs.iam_role_arn
  service_account_name = "external-dns-sa"
  service_account_annotations = {
    "eks.amazonaws.com/role-arn"               = dependency.iam_role.outputs.iam_role_arn
    "eks.amazonaws.com/sts-regional-endpoints" = "true"
  }
}
