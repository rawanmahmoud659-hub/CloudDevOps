module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  private_subnet_ids = module.main_vpc.private_subnet_ids
}
