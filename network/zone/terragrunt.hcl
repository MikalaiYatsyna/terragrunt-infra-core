include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/route53/aws?version=0.0.1"
}

inputs = {
  domain = include.root.locals.domain
}
