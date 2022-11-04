resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.type
  associate_public_ip_address = true
  key_name                    = module.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.pub_subnet.*.id[0]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 100
  }
  tags = {
    Name = "${var.NAME}"
  }
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  public_key = trimspace(tls_private_key.key.public_key_openssh)
}

resource "null_resource" "key" {
  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.key.private_key_pem}' > ./'${var.NAME}'.pem
      sudo chmod 400 ./'${var.NAME}'.pem
    EOT
  }
}
#resource "aws_key_pair" "my_key" {
#  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
#}

resource "null_resource" "kubernetes" {
  provisioner "remote-exec" {
    inline = ["cloud-init status --wait", " bash /root/terraform-task/new-tasks/setup.sh"]
  }


  # Login to the centos-user with the aws key.
  connection {
    type        = "ssh"
    user        = "centos"
    password    = ""
    private_key = '${var.NAME}'.pem
    host        = aws_instance.instance.public_ip
  }
}

resource "aws_ssm_document" "cloud_init_wait" {
  name = "cloud-init-wait"
  document_type = "Command"
  document_format = "YAML"
  content = <<-DOC
    schemaVersion: '2.2'
    description: Wait for cloud init to finish
    mainSteps:
    - action: aws:runShellScript
      name: StopOnLinux
      precondition:
        StringEquals:
        - platformType
        - Linux
      inputs:
        runCommand:
        - cloud-init status --wait
    DOC
}
