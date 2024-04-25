terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }

    kind = {
      source = "tehcyx/kind"
      version = "0.2.1"
    }    

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.22.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "./kind-cluster-config"
}

provider "kind" {
  
}