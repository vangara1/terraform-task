resource "kubernetes_storage_class" "standard" {
  metadata {
    name = "local"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  parameters {
    type      = "gp2"
    encrypted = "true"
  }
}