include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://${include.root.locals.aws.ecr}//.?version=${include.root.locals.aws.ecr}"
}

inputs = {
  repo_name = "vault-init"
}
