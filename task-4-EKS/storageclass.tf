resource "kubernetes_storage_class" "example" {
  metadata {
    name = "local-terra-style-example"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"
  parameters = {
    type = "pd-standard"
  }
}