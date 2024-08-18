variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "europe-central2-c"
  description = "GCP region to use"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "g1-small"
  description = "Machine type"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 2
  description = "GKE nodes number"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "main"
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  default     = "main"
  description = "GKE pool name"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "The GitHub owner"
}

variable "GITHUB_TOKEN" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "FLUX_GITHUB_REPO" {
  description = "Name of the GitHub repository used by Flux"
  type        = string
}