terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.1.0"
    }
  }
}

module "github_repository" {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "gke_cluster" {
  source           = "github.com/den-vasyliev/tf-google-gke-cluster"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
  GKE_NUM_NODES    = 3
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_POOL_NAME    = var.GKE_POOL_NAME
}

provider "flux" {
  kubernetes = {
    config_path = module.gke_cluster.kubeconfig
  }
  git = {
    url = "https://github.com/${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}.git"
    http = {
      username = "git"
      password = var.GITHUB_TOKEN
    }
  }
}

module "flux_bootstrap" {
  source            = "github.com/YuriiKosiy/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = module.gke_cluster.kubeconfig
  github_token      = var.GITHUB_TOKEN
  target_path       = "clusters/p72-flux"
  depends_on        = [module.gke_cluster]
}

module "tls_private_key" {
  source    = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}
