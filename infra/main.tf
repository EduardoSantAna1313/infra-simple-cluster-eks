data "aws_caller_identity" "this"{}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.19.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true
  create_kms_key                 = false

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  # Pipeline role
  aws_auth_roles = [
    {
      
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:role/github_action_workflows_role"
      username = "pipelinerole"
      groups = [
        "system:masters"
      ]
    }
  ]

  eks_managed_node_group_defaults = {
    instance_types = ["t3.small", "t3.medium"]
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-business"

      instance_types = [var.instance_type]

      min_size     = 1
      max_size     = var.max_instances
      desired_size = var.desired_size
    }

    /*
    two = {
      name = "node-group-2"

      instance_types = [var.instance_type]

      min_size     = 1
      max_size     = var.max_instances
      desired_size = var.desired_size
    }*/
  }
}
