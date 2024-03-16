include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/secret-backends/vault?version=0.0.4"
}

dependency "vault" {
  config_path = "${get_repo_root()}/kubernetes/tools/vault"
}

inputs = {
  vault_address         = dependency.vault.outputs.vault_address
  vault_token_secret_id = dependency.vault.outputs.vault_token_secret_id
}
