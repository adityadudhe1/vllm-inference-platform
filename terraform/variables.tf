variable "location" {
  type    = string
  default = "South India"
}

variable "resource_group_name" {
  type    = string
  default = "rg-vllm-inference-platform"
}

variable "vnet_name" {
  type    = string
  default = "vnet-vllm"
}

variable "subnet_name" {
  type    = string
  default = "snet-vllm"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.10.1.0/22"]
}
