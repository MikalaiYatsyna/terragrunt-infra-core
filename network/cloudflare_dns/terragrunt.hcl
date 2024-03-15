include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr://app.terraform.io/logistic/dns-records/cloudflare?version=0.0.2"
}

dependency "zone" {
  config_path = "${get_repo_root()}/network/zone"
}

inputs = {
  domain      = include.root.locals.domain
  root_domain = include.root.locals.root_domain
  records = {
    NS = toset(dependency.zone.outputs.nameservers)
  }
}
