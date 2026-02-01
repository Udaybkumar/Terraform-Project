#---------------------------------------------------------------
# IAM Role for Service Account - AWS EBS CSI DRIVER
#---------------------------------------------------------------
resource "random_pet" "ebs_csi_driver_pet" {
  length = 2
}

resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "${var.cluster-name}-ebs-csi-driver-role-${random_pet.ebs_csi_driver_pet.id}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_driver_role.name
}

#---------------------------------------------------------------
# IAM Role for Service Account - CoreDNS
#---------------------------------------------------------------
resource "random_pet" "coredns_pet" {
  length = 2
}
resource "aws_iam_role" "coredns_role" {
  name = "${var.cluster-name}-coredns-role-${random_pet.coredns_pet.id}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:coredns"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "coredns_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.coredns_role.name
}

#---------------------------------------------------------------
# IAM Role for Service Account - Kube Proxy
#---------------------------------------------------------------
resource "random_pet" "kube_proxy_pet" {
  length = 2
}
resource "aws_iam_role" "kube_proxy_role" {
  name = "${var.cluster-name}-kube-proxy-role-${random_pet.kube_proxy_pet.id}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:kube-proxy"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kube_proxy_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.kube_proxy_role.name
}
