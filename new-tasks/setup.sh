#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
yum list docker-ce --showduplicates | sort -r -- to find the list of versions.
sudo yum install docker-ce docker-ce-cli containerd.io --to install latest version -y
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo su -
sudo cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum -y install vim git curl wget kubelet kubeadm kubectl
sudo systemctl enable kubelet
kubeadm version
sudo kubeadm init

sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl restart docker
sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
