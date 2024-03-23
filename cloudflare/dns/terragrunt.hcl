include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/dns-records/cloudflare?version=0.0.3"
}

dependency "zone" {
  config_path = "${get_repo_root()}/aws/route53"
}

inputs = {
  domain      = include.root.locals.domain
  root_domain = include.root.locals.root_domain
  records = {
    NS = toset(dependency.zone.outputs.nameservers)
  }
}
