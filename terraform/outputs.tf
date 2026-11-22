output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_urls" {
  value = [for repo in module.ecrs : repo.ecr_repo_url]
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}

output "eks_node_group_arns" {
  value = module.eks.node_group_arns
}

output "gh_oidc_role" {
  value = aws_iam_role.github_actions_ecr.arn
}