#resource "kubernetes_storage_class" "expandable-storage" {
#  metadata {
#    name = "expandable-storage"
#  }
#  storage_provisioner = "kubernetes.io/aws-ebs"
#  reclaim_policy      = "Retain"
#  parameters = {
#    type = "gp3"
#    fsType: "ext4"
#    encrypted: "true"
#  }
#  allow_volume_expansion = true
#  volume_binding_mode = "Immediate"
#}
#
#resource "kubernetes_storage_class" "storage" {
#  metadata {
#    name = "storage"
#  }
#
#  storage_provisioner = "kubernetes.io/gce-pd"
#  reclaim_policy      = "Retain"
#  parameters = {
#    type = "pd-standard"
#  }
#  mount_options = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
#}
##
#resource "null_resource" "k8s_storage_class_patch" {
#  depends_on = [kubernetes_storage_class.expandable-storage]
#  provisioner "local-exec" {
#    command = "/bin/bash scripts/storage_class_patch.sh"
#  }
#}