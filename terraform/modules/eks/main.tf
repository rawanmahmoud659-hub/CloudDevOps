resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = values(var.private_subnet_ids)
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  dynamic "access_config" {
    for_each = var.authentication_mode == null ? [] : [var.authentication_mode]

    content {
      authentication_mode = access_config.value
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster,
    aws_iam_role_policy_attachment.vpc_resource_controller,
  ]
}

resource "aws_eks_node_group" "nodes" {
  for_each        = var.private_subnet_ids
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-workers-${each.key}"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = [each.value]
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  capacity_type   = var.capacity_type
  disk_size       = var.disk_size

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_worker,
    aws_iam_role_policy_attachment.node_cni,
    aws_iam_role_policy_attachment.node_ecr
  ]
}


resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "eks-pod-identity-agent"

  depends_on = [
    aws_eks_node_group.nodes,
  ]
}

resource "aws_eks_pod_identity_association" "ebs_csi" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi_role.arn

  depends_on = [
    aws_iam_role_policy_attachment.eks_ebs_csi_policy,
    aws_eks_addon.pod_identity_agent,
  ]
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "aws-ebs-csi-driver"

  depends_on = [
    aws_eks_node_group.nodes,
    aws_eks_pod_identity_association.ebs_csi,
  ]
}
