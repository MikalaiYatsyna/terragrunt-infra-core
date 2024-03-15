#include "root" {
#  path   = find_in_parent_folders()
#  expose = true
#}
#
#terraform {
#  source = "tfr://app.terraform.io/logistic/argo-cd/aws?version=0.0.1"
#}
#
#dependency "cluster" {
#  config_path = "${get_repo_root()}/kubernetes/cluster"
#}
#
#dependency "cert_manager_issuer" {
#  config_path = "${get_repo_root()}/kubernetes/tools/cert_manager_issuer"
#}
#
#dependency "external_dns" {
#  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
#  skip_outputs = true
#}
#
#dependency "namespace" {
#  config_path = "${get_repo_root()}/kubernetes/namespace/argo"
#}
#
#inputs = {
#  cluster_name       = dependency.cluster.outputs.cluster_name
#  certificate_issuer = dependency.cert_manager_issuer.outputs.letsencrypt_issuer
#  domain             = include.root.locals.domain
#  namespace          = dependency.namespace.outputs.name
#}
#include "root" {
#  path   = find_in_parent_folders()
#  expose = true
#}
#
#terraform {
##  source = "tfr://app.terraform.io/logistic/argo-cd/aws?version=0.0.1"
#  source = "/Users/mikalai_yatsyna/IdeaProjects/Logistics/infra/kubernetes/argo-cd"
#}
#
#dependency "cluster" {
#  config_path = "${get_repo_root()}/aws/eks"
#}
#
#dependency "cert_manager_issuer" {
#  config_path = "${get_repo_root()}/kubernetes/tools/cert_manager_issuer"
#}
#
#dependency "external_dns" {
#  config_path  = "${get_repo_root()}/kubernetes/tools/external_dns"
#  skip_outputs = true
#}
#
#dependency "namespace" {
#  config_path = "${get_repo_root()}/kubernetes/namespace/argo"
#}
#
#inputs = {
#  certificate_issuer = dependency.cert_manager_issuer.outputs.letsencrypt_issuer
#  domain             = include.root.locals.domain
#  namespace          = dependency.namespace.outputs.name
#  cluster_endpoint = dependency.cluster.outputs.cluster_endpoint
#  cluster_ca       = dependency.cluster.outputs.cluster_ca
#  k8s_exec_args    = concat(include.root.locals.k8s_auth_exec_args, [dependency.cluster.outputs.cluster_name])
#  k8s_exec_command = include.root.locals.k8s_exec_command
#}
