provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file (pointing to your EKS cluster)
}

resource "kubernetes_namespace" "golang" {
  metadata {
    name = "golang-api"
  }
}

resource "kubernetes_manifest" "golang_api" {
  manifest = yamldecode(file("${path.module}/golang-api.yaml"))
}

output "load_balancer_dns" {
  value = kubernetes_service.golang_api_service.status[0].load_balancer.ingress[0].hostname
}