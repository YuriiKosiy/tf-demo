module "gke_cluster" {
  source           = "github.com/YuriiKosiy/tf-demo"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = 2
  GKE_DISK_SIZE_GB = 50
}