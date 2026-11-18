resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = values(var.private_subnet_ids)
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [aws_iam_role_policy_attachment.cluster]
}

resource "aws_eks_node_group" "workers" {
  for_each        = var.private_subnet_ids
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-workers-${each.key}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = [each.value]
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_worker,
    aws_iam_role_policy_attachment.node_cni,
    aws_iam_role_policy_attachment.node_ecr
  ]
}
