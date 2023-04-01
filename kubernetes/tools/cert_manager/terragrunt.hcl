include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://${include.root.locals.kubernetes.tools.cert_manager.source}//.?version=${include.root.locals.kubernetes.tools.cert_manager.version}"
}

dependency "kubernetes_cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}


dependency "cert_manager_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/cert_manager"
}

inputs = {
  stack             = include.root.locals.stack
  cluster_name      = dependency.kubernetes_cluster.outputs.cluster_name
  domain            = include.root.locals.domain
  namespace         = dependency.cert_manager_namespace.outputs.name
  oidc_provider_arn = dependency.kubernetes_cluster.outputs.oidc_provider_arn
}
