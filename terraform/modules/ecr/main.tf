
resource "aws_ecr_repository" "main_ecr" {
  name                 = var.ecr_name
  image_tag_mutability = (var.is_mutable) ? "MUTABLE" : "IMMUTABLE"
}