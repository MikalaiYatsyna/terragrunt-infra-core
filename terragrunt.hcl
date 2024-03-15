locals {
  stack             = "core"
  root_domain       = get_env("ROOT_DOMAIN")
  region            = get_env("AWS_REGION")
  ecr_url           = get_env("ECR_URL")
  email             = get_env("EMAIL")
  state_bucket_name = get_env("TF_STATE_BUCKET")
  domain            = "${local.stack}.${local.root_domain}"

  kubernetes = {
    cluster = {
      source  = "app.terraform.io/logistic/eks/aws"
      version = "0.0.8"
    }
    namespace = {
      source  = "app.terraform.io/logistic/eks-ns/aws"
      version = "0.0.2"
    }
    tools = {
      autoscaler = {
        source  = "app.terraform.io/logistic/eks-autoscaler/aws"
        version = "0.0.1"
      }
      ingress = {
        source  = "app.terraform.io/logistic/eks-ingress/aws"
        version = "0.0.11"
      }
      consul = {
        source  = "app.terraform.io/logistic/consul/aws"
        version = "0.0.9"
      }
      vault = {
        source  = "app.terraform.io/logistic/vault/aws"
        version = "0.0.9"
      }
      cert_manager = {
        source  = "app.terraform.io/logistic/eks-cert-manager/aws"
        version = "0.0.2"
      }
      cert_manager_issuer = {
        source  = "app.terraform.io/logistic/cert-manager-issuer/aws"
        version = "0.0.6"
      }
      vault_backends = {
        source  = "app.terraform.io/logistic/secret-backends/vault"
        version = "0.0.3"
      }
      vault_k8s = {
        source  = "app.terraform.io/logistic/k8s-auth/vault"
        version = "0.0.1"
      }
      external_dns = {
        source  = "app.terraform.io/logistic/external-dns/aws"
        version = "0.0.2"
      }
      argo_cd = {
        source  = "app.terraform.io/logistic/argo-cd/aws"
        version = "0.0.1"
      }
    }
  }
  network = {
    vpc = {
      source  = "app.terraform.io/logistic/vpc/aws"
      version = "0.0.5"
    }
    cloudflare_dns_record = {
      source  = "app.terraform.io/logistic/dns-records/cloudflare"
      version = "0.0.2"
    }
  }
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
