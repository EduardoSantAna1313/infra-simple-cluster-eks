# infra-simple-cluster-eks

Cluster EKS em terraform com configuração minima utilizando o módulo [terraform-aws-modules](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)

Pipeline com github actions. Necessário setar as variaveis:

- AWS_ASSUME_ROLE: Role com as permissões para criar recurso via OIDC.
- AWS_REGION: Região AWS para criação dos recursos.
- BUCKET_STATE: Bucket para salvar o terraform.tfstate.
