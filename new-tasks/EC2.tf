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
#  provisioner "remote-exec" {
#    inline = ["cloud-init status --wait"]
#  }
  provisioner "local-exec" {
    command = <<-EOT
      bash /root/terraform-task/new-tasks/setup.sh
EOT
  }
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
#
#resource "null_resource" "kubernetes" {
#
#
#
#    }


## Login to the centos-user with the aws key.
#connection {
#  type        = "ssh"
#  user        = "centos"
#  password    = ""
#  private_key = file(var.keyPath)
#  host        = self.public_ip
#}
#} # end resource