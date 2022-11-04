resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.type
  associate_public_ip_address = true
  key_name                    = var.key
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

resource "aws_key_pair" "my_key" {
  key_name   = "fresh"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "null_resource" "kubernetes" {
  provisioner "remote-exec" {
    inline = ["cloud-init status --wait", " bash /root/terraform-task/new-tasks/setup.sh"]
  }


  # Login to the centos-user with the aws key.
  connection {
    type        = "ssh"
    user        = "centos"
    password    = ""
    private_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    host        = aws_instance.instance.public_ip
  }
}
# end resource