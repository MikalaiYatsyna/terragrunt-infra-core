include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/cert-manager-issuer/kubernetes?version=0.0.8"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/aws/eks"
}

dependency "cert_manager_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/cert_manager"
}

dependency "cert_manager" {
  config_path  = "${get_repo_root()}/kubernetes/tools/cert_manager"
  skip_outputs = true
}

dependency "route53" {
  config_path = "${get_repo_root()}/aws/route53"
}

inputs = {
  stack            = include.root.locals.stack
  aws_region           = include.root.locals.region
  email            = include.root.locals.email
  namespace        = dependency.cert_manager_namespace.outputs.name
  cluster_endpoint = dependency.cluster.outputs.cluster_endpoint
  cluster_ca       = dependency.cluster.outputs.cluster_ca
  k8s_exec_args    = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
  k8s_exec_command = include.root.locals.k8s_exec_command
  route53_zone_id  = dependency.route53.outputs.zone_id
}
