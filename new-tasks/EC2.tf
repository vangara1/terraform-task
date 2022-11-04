#resource "aws_instance" "instance" {
#  ami                         = var.ami
#  instance_type               = var.type
#  associate_public_ip_address = true
#  key_name                    = aws_key_pair.my_key.key_name
#  vpc_security_group_ids      = [aws_security_group.sg.id]
#  subnet_id                   = aws_subnet.pub_subnet.*.id[0]
#  ebs_block_device {
#    device_name = "/dev/sda1"
#    volume_size = 100
#  }
#  tags = {
#    Name = "${var.NAME}"
#  }
#}
#
#resource "aws_key_pair" "my_key" {
#  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
#}
#resource "null_resource" "key" {
#    provisioner "local-exec" {
#      command = <<-EOT
#        sudo cd ~/.ssh
#        sudo chmod 400 ~/.ssh/id_rsa
#      EOT
#    }
#}
#resource "null_resource" "kubernetes" {
#  provisioner "remote-exec" {
#    inline = ["cloud-init status --wait"]
#  }
#
#    provisioner "local-exec" {
#      command = <<-EOT
#      sudo su -
#sudo yum install -y yum-utils
#sudo yum-config-manager \
#--add-repo \
#https://download.docker.com/linux/centos/docker-ce.repo
#yum list docker-ce --showduplicates | sort -r -- to find the list of versions.
#sudo yum install docker-ce docker-ce-cli containerd.io --to install latest version -y
#sudo systemctl start docker
#sudo systemctl enable docker
#sudo systemctl status docker
#sudo swapoff -a
#sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
#sudo cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
#[kubernetes]
#name=Kubernetes
#baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
#enabled=1
#gpgcheck=1
#repo_gpgcheck=0
#gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
#EOF
#sudo yum -y install vim git curl wget kubelet kubeadm kubectl
#sudo systemctl enable kubelet
#kubeadm version
#sudo kubeadm init
#sudo rm /etc/containerd/config.toml
#sudo systemctl restart containerd
#sudo systemctl restart docker
#sudo kubeadm init
#    EOT
#  }
#  # Login to the centos-user with the aws key.
#  connection {
#    type        = "ssh"
#    user        = "centos"
#    password    = ""
#    private_key = file(pathexpand("~/.ssh/id_rsa"))
#    host        = aws_instance.instance.public_ip
#  }
#}
#}
#resource "aws_ssm_document" "cloud_init_wait" {
#  name = "cloud-init-wait"
#  document_type = "Command"
#  document_format = "YAML"
#  content = <<-DOC
#    schemaVersion: '2.2'
#    description: Wait for cloud init to finish
#    mainSteps:
#    - action: aws:runShellScript
#      name: StopOnLinux
#      precondition:
#        StringEquals:
#        - platformType
#        - Linux
#      inputs:
#        runCommand:
#        - cloud-init status --wait
#    DOC
#}


resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_key.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.pub_subnet.*.id[0]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 100
  }
  connection {
    host        = aws_instance.instance.public_dns
    user        = "centos"
    private_key = tls_private_key.key.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y yum-utils"
      "sudo yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo"
      "sudo yum list docker-ce --showduplicates | sort -r -- to find the list of versions"
      "sudo yum install docker-ce docker-ce-cli containerd.io --to install latest version -y"
      "sudo systemctl start docker"
      "sudo systemctl enable docker"
      "sudo systemctl status docker"
      "sudo swapoff -a"
      "sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab"
      "sudo yum -y install vim git curl wget kubelet kubeadm kubectl"
      "sudo systemctl enable kubelet"
      "kubeadm version"
      "sudo kubeadm init"
      "sudo rm /etc/containerd/config.toml"
      "sudo systemctl restart containerd"
      'sudo systemctl restart docker'
      "sudo kubeadm init"
      "mkdir -p $HOME/.kube"
      "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
      "sudo chown $(id -u):$(id -g) $HOME/.kube/config"
      "sudo kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml"
    ]
  }
  tags = {
    Name = "${var.NAME}"
  }
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
}


resource "null_resource" "key" {
  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.key.private_key_pem}' > ./'${var.NAME}'.pem
      sudo chmod 400 ./'${var.NAME}'.pem
    EOT
  }
}
resource "aws_key_pair" "my_key" {
  public_key = trimspace(tls_private_key.key.public_key_openssh)
}




