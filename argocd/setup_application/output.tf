output "public_key_openssh" {
  value = tls_private_key.argocd.public_key_openssh
}
