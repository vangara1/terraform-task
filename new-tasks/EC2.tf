resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.type
  associate_public_ip_address = true
  key_name                    = var.key
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.pub_subnet.*.id[0]
  tags                        = {
    Name = "${var.NAME}"
  }
}

resource "null_resource" "kubernetes" {

  provisioner "remote-exec" {
    connection {
      host = aws_instance.instance.public_dns
      user = "centos"
      file = file("files/id_rsa")
    }

    inline = ["echo 'connected!'"]
  }

    provisioner "local-exec" {
      command = <<-EOT
      bash /root/terraform-task/new-tasks/setup.sh
EOT
    }
    }


## Login to the centos-user with the aws key.
#connection {
#  type        = "ssh"
#  user        = "centos"
#  password    = ""
#  private_key = file(var.keyPath)
#  host        = self.public_ip
#}
#} # end resource