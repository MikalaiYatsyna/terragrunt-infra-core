include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/k8s-auth/vault?version=0.0.1"
}

dependency "vault" {
  config_path = "${get_repo_root()}/kubernetes/tools/vault"
}

dependency "kubernetes_cluster" {
  config_path = "${get_repo_root()}/kubernetes/cluster"
}

dependency "hashicorp_namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/hashicorp"
}

inputs = {
  vault_address         = dependency.vault.outputs.vault_address
  vault_sa              = dependency.vault.outputs.vault_sa
  cluster_name          = dependency.kubernetes_cluster.outputs.cluster_name
  namespace             = dependency.hashicorp_namespace.outputs.name
  vault_token_secret_id = dependency.vault.outputs.vault_token_secret_id
}
