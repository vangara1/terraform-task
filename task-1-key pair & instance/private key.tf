resource "tls_private_key" "wave-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.NAME
  public_key = tls_private_key.wave-key.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.wave-key.private_key_pem}' > ./'${var.NAME}'.pem
      sudo chmod 400 ./'${var.NAME}'.pem
    EOT
  }
}
