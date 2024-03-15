include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/vpc/aws?version=0.0.5"
}

inputs = {
  stack = include.root.locals.stack
}
