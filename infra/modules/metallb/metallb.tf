resource "kubernetes_namespace" "metallb"{
  metadata{
    name          = "metallb-system"
  }
}

resource "helm_release" "metallb" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"

  timeout         = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "metallb-system"

  depends_on = [kubernetes_namespace.metallb]
}

resource "kubectl_manifest" "metallb" {
    depends_on = [kubernetes_namespace.metallb]
    yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: ip-address-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.18.255.200-172.18.255.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: empty
  namespace: metallb-system
YAML
}