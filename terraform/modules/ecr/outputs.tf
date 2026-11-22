output "ecr_repo_url" {
  value = aws_ecr_repository.main_ecr.repository_url
}

output "ecr_repo_arn" {
  value = aws_ecr_repository.main_ecr.arn
}
