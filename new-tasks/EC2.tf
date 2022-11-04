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


  provisioner "file" {
    source      = "/root/terraform-task/new-tasks/setup.sh"
    destination = "/tmp"
  }

  # Change permissions on bash script and execute from centos
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp",
      "bash setup.sh"
    ]
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