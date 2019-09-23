# Generate a keypair. The private key will go to Flux in-cluster, public key
# will be added as a deploy key to the Github repo.

resource "tls_private_key" "flux" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

provider "github" {
  organization = "${var.github_org_name}"
}

data "github_repository" "flux-repo" {
  name = "${var.github_repository_name}"
}

resource "github_repository_deploy_key" "flux" {
  title      = "Flux deploy key (eks-${var.eks_cluster_name})"
  repository = "${data.github_repository.flux-repo.name}"
  read_only  = false
  key        = "${tls_private_key.flux.public_key_openssh}"
}