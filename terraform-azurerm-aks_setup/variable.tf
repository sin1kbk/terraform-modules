variable "name_prefix" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "standard_b2ms"
}

variable "os_disk_size_gb" {
  type    = string
  default = 100
}

variable "node_count" {
  type    = number
  default = 1
}

variable "subnet" {
  type = string
}

variable "dns_service_ip" {
  type = string
}
