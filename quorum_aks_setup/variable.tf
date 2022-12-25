variable "arm_template_parameters" {
  type = object({
    resource_group : object({
      name : string
      location : string
    })
    subnet : string
    vm_size : string
    node_count : number
    node_disksize_gb : number
  })

  default = {
    resource_group = {
      name : "quorum"
      location : "japaneast"
    }
    subnet           = "192.168.0.0/20"
    vm_size          = "standard_b2ms"
    node_disksize_gb = 100
    node_count       = 1
  }
}
