# Resource to create SSH Key or Private Key
resource "tls_private_key" "demo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "demo_key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.demo_key.public_key_openssh
}

resource "null_resource" "display_public_key" {
  provisioner "local-exec" {
    command = "echo 'Public Key: ${aws_key_pair.demo_key_pair.public_key}'"
  }

  depends_on = [aws_key_pair.demo_key_pair]
}
