variable "location" {
  type    = string
  default = "West Europe"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "vnet_subnet_adress_prefixes" {
  type    = list(list(string))
  default = [["10.0.1.0/24"], ["10.0.2.0/24"]]
}

variable "tags" {
  type = map(string)
  default = {
    subject = "BST"
  }
}

variable "vm_size" {
  type    = string
  default = "Standard_B1ls"
}

variable "vm_admin_username" {
  type    = string
  default = "arek"
}

variable "vm_path_to_public_key" {
  type    = string
  default = "~/.ssh/az-bst.pub"
}

variable "vm_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}
