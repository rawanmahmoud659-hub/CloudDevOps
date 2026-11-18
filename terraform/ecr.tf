module "ecrs" {
  count      = length(var.ecr_repos)
  source     = "./modules/ecr"
  ecr_name   = var.ecr_repos[count.index]
  is_mutable = true
}
