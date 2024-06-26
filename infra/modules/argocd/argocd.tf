resource "kubernetes_namespace" "argocd"{
  metadata{
    name          = "argocd"
  }
}

resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"

  values = [file("${path.module}/values.yaml")]
}

resource "kubectl_manifest" "argosecret" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: githubsecret
  namespace: ${var.namespace}
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: git
  url: git@github.com:iriscafe/desafio-devops.git
  sshPrivateKey: "|
-----BEGIN OPENSSH PRIVATE KEY-----

-----END OPENSSH PRIVATE KEY-----"
YAML  
}
resource "kubectl_manifest" "application" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    namespace: application
    server: "https://kubernetes.default.svc"
  source:
    path: "helm/my-python-app"
    repoURL: "git@github.com:iriscafe/desafio-devops.git"
    targetRevision: "HEAD"
    helm:
      valueFiles:
        - "values.yaml"
  project: "default"
  syncPolicy:
    managedNamespaceMetadata:
      labels:
        managed: "argo-cd"
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
  retry:
    limit: 5
    backoff:
      duration: 5s
      maxDuration: 3m0s
      factor: 2
YAML 
}

resource "kubectl_manifest" "grafana" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: grafana
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination: 
    namespace: monitoring
    server: "https://kubernetes.default.svc"
  source:
    path: "helm/grafana"
    repoURL: "git@github.com:iriscafe/desafio-devops.git"
    targetRevision: "HEAD"
    helm:
      valueFiles:
        - "values.yaml"
  project: "default"
  syncPolicy:
    managedNamespaceMetadata:
      labels:
        managed: "argo-cd"
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
  retry:
    limit: 5
    backoff:
      duration: 5s
      maxDuration: 3m0s
      factor: 2
YAML 
}

resource "kubectl_manifest" "prometheus" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: prometheus
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    namespace: monitoring
    server: "https://kubernetes.default.svc"
  source:
    path: "helm/prometheus"
    repoURL: "git@github.com:iriscafe/desafio-devops.git"
    targetRevision: "HEAD"
    helm:
      valueFiles:
        - "values.yaml"
  project: "default"
  syncPolicy:
    managedNamespaceMetadata:
      labels:
        managed: "argo-cd"
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
  retry:
    limit: 5
    backoff:
      duration: 5s
      maxDuration: 3m0s
      factor: 2
YAML 
}

resource "kubectl_manifest" "kube_metrics" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kube-metrics
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    namespace: monitoring
    server: "https://kubernetes.default.svc"
  source:
    path: "helm/kube_metrics"
    repoURL: "git@github.com:iriscafe/desafio-devops.git"
    targetRevision: "HEAD"
    helm:
      valueFiles:
        - "values.yaml"
  project: "default"
  syncPolicy:
    managedNamespaceMetadata:
      labels:
        managed: "argo-cd"
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - PruneLast=true
  retry:
    limit: 5
    backoff:
      duration: 5s
      maxDuration: 3m0s
      factor: 2
YAML 
}