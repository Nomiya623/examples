# _locals.tf
locals {
  ## Common Configs
  name             = "${var.environment}-${var.project}"
  my_ip            = "112.171.56.11/32"
  keypair_name     = "${var.environment}-${var.project}-keypair"  
  vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
  private_subnets  = data.terraform_remote_state.network.outputs.private_subnets
  public_subnets   = data.terraform_remote_state.network.outputs.public_subnets
  bastion_role_arn = aws_iam_role.bastion.arn

  # EKS Cluster Configs
  # 각 실습마다 스펙이 변경될 수도 있음 (기본 t2.micro)
  node_type     = ["t2.micro"]
  node_size     = 5
  node_max_size = 5
  node_min_size = 1

  addons = [
    {
      addon_name    = "kube-proxy"
      addon_version = "v1.30.6-eksbuild.3"
    },
    {
      addon_name    = "coredns"
      addon_version = "v1.11.1-eksbuild.8"
    },
    {
      addon_name    = "vpc-cni"
      addon_version = "v1.19.0-eksbuild.1"
    },
    #
    # EBS CSI Driver
    # {
    #   addon_name    = "aws-ebs-csi-driver"
    #   addon_version = "v1.37.0-eksbuild.1"
    # },
    #
    # Pod Identity
    # {
    #   addon_name    = "eks-pod-identity-agent"
    #   addon_version = "v1.3.4-eksbuild.1"
    # }
  ]

  access_config = {
    authentication_mode = "API"
  }

  access_entry_map = {
    "arn:aws:iam::357836924303:user/admin" = {
      type              = "STANDARD"
      access_policy_associations = {
        "ClusterAdmin" = {
          access_scope = {
            type       = "cluster"
            namespaces = null
          }
        }
      }
    },
    "arn:aws:iam::357836924303:role/bastion-role" = {
      type              = "STANDARD"
      access_policy_associations = {
        "ClusterAdmin" = {
          access_scope = {
            type       = "cluster"
            namespaces = null
          }
        }
      }
    }
  }
}