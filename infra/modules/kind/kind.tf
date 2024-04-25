resource "kind_cluster" "default" {
  name           = "kind-cluster"
  wait_for_ready = true

  kind_config {
      kind        = "Cluster"
      api_version = "kind.x-k8s.io/v1alpha4"
      
      node {
          role = "control-plane"

          kubeadm_config_patches = [
              "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
          ]

          extra_port_mappings {
              container_port = 30443
              host_port      = 8080
              listen_address  = "0.0.0.0"
              protocol       = "TCP"
          }
      }
      node {
        role = "worker"
      }
  }
}