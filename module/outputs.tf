output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.eks[0].name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.eks[0].endpoint
}

output "cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL for the EKS cluster"
  value       = aws_eks_cluster.eks[0].identity[0].oidc[0].issuer
}
