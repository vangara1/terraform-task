resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#module "key_pair" {
#  source = "terraform-aws-modules/key-pair/aws"
#
#  key_name = var.NAME
#  public_key = tls_private_key.key.public_key_openssh
#}
resource "aws_key_pair" "key_pair" {
  key_name   = var.NAME
  public_key = tls_private_key.key.public_key_openssh
}

resource "null_resource" "key-wave" {
  provisioner "local-exec" {
    command = <<-EOF
      sudo echo '${tls_private_key.key.private_key_pem}' > ./'${var.NAME}'.pem
      sudo chmod 400 ./'${var.NAME}'.pem
    EOF
  }
}
