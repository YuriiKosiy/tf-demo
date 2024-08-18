module "github_repository" {
  source                   = "github.com/YuriiKosiy/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
}

module "gke_cluster" {
  source           = "github.com/YuriiKosiy/tf-google-gke-cluster"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
  GKE_NUM_NODES    = 1
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_POOL_NAME    = var.GKE_POOL_NAME
}

module "tls_private_key" {
  source    = "github.com/YuriiKosiy/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

#terraform {
#  backend "gcs" {
#    bucket = "p72-demo"
#    prefix = "terraform/state"
#  }
#}