module "kind" {
  source       = "./modules/kind"
}

module "metallb" {
   source       = "./modules/metallb"
}

# module "argocd" {
#    source       = "./modules/argocd"
# }