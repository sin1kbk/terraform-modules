resource "null_resource" "port-forward" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
      ${path.module}/port-forward.sh ${var.kubeconfig_path} ${var.namespace} ${var.service} ${var.host_port} ${var.target_port} >/dev/null 2>&1 &
      sleep 5
    EOT
  }
}
