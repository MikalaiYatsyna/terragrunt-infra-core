locals {
  stack                 = get_env("PLATFORM")
  root_domain           = get_env("ROOT_DOMAIN")
  region                = get_env("AWS_REGION")
  ecr_url               = get_env("ECR_URL")
  email                 = get_env("EMAIL")
  state_bucket_name     = get_env("TF_STATE_BUCKET")
  state_lock_table_name = get_env("TF_STATE_LOCK_TABLE")
  domain                = "${local.stack}.${local.root_domain}"
  k8s_auth_exec_args    = ["eks", "get-token", "--cluster-name"]
  k8s_exec_command      = "aws"
}

remote_state {
  backend = "s3"
  config = {
    region         = local.region
    bucket         = local.state_bucket_name
    key            = "${local.stack}/${path_relative_to_include()}.tfstate"
    dynamodb_table = local.state_lock_table_name
    encrypt        = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
