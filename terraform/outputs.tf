output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_urls" {
  value = [for repo in module.ecrs : repo.ecr_repo_url]
}
