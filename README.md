# Terragrunt
Terragrunt code for provisioning core resources.
```
├── kubernetes
│   ├── cluster
│   │   └── terragrunt.hcl
│   ├── namespace
│   │   └── core
│   │       └── terragrunt.hcl
│   └── tools
│       ├── autoscaler
│       │   └── terragrunt.hcl
│       ├── cert_manager
│       │   └── terragrunt.hcl
│       ├── cert_manager_issuer
│       │   └── terragrunt.hcl
│       ├── consul
│       │   └── terragrunt.hcl
│       ├── external_dns
│       │   └── terragrunt.hcl
│       ├── ingress
│       │   └── terragrunt.hcl
│       ├── vault
│       │   └── terragrunt.hcl
│       └── vault_config
│           ├── k8s-auth
│           │   └── terragrunt.hcl
│           └── secret_backends
│               └── terragrunt.hcl
├── network
│   ├── cloudflare_dns
│   │   └── terragrunt.hcl
│   ├── vpc
│   │   └── terragrunt.hcl
│   └── zone
│       └── terragrunt.hcl
└── terragrunt.hcl
```
