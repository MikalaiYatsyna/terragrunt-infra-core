locals {
  stack             = "core"
  root_domain       = get_env("ROOT_DOMAIN")
  region            = get_env("AWS_REGION")
  ecr_url           = get_env("ECR_URL")
  email             = get_env("EMAIL")
  state_bucket_name = get_env("TF_STATE_BUCKET")
  domain            = "${local.stack}.${local.root_domain}"
}

remote_state {
  backend = "s3"
  config = {
    region         = local.region
    bucket         = local.state_bucket_name
    key            = "${local.stack}/${path_relative_to_include()}.tfstate"
    dynamodb_table = "tf_state_lock"
    encrypt        = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
