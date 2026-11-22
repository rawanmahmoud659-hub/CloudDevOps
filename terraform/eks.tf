module "eks" {
  source              = "./modules/eks"
  cluster_name        = var.cluster_name
  private_subnet_ids  = module.main_vpc.private_subnet_ids
  cluster_version     = var.eks_kubernetes_version
  authentication_mode = var.eks_authentication_mode

  node_desired_size = var.min_node_size
  node_min_size     = var.min_node_size
}
