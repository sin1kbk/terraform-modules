# M1 mac未対応のためlocal execで実施
#resource "kind_cluster" "default" {
#  name = var.name
#}

resource "null_resource" "mac_install" {
  provisioner "local-exec" {
    command = "brew install kind && kind create cluster --config ${path.module}/multi-node.yml"
  }
}
