include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks?version=5.37.1"
}

dependency "cluster" {
  config_path = "${get_repo_root()}/aws/eks"
}

dependency "namespace" {
  config_path = "${get_repo_root()}/kubernetes/namespace/external_dns"
}


inputs = {
  role_name                  = "${include.root.locals.stack}-external-dns-role"
  attach_external_dns_policy = true
  oidc_providers = {
    main = {
      provider_arn               = dependency.cluster.outputs.oidc_provider_arn
      namespace_service_accounts = ["${dependency.namespace.outputs.name}:external-dns-sa"]
    }
  }
}
