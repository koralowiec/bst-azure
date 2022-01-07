resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vm1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username

  network_interface_ids = [
    azurerm_network_interface.vm1_interface.id
  ]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file(var.vm_path_to_public_key)
  }

  os_disk {
    caching              = "None"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_image_reference.publisher
    offer     = var.vm_image_reference.offer
    sku       = var.vm_image_reference.sku
    version   = var.vm_image_reference.version
  }
}

resource "azurerm_public_ip" "vm1_public_ip" {
  name                = "public-ip-for-vm1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_network_interface" "vm1_interface" {
  name                = "vm1-interface"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "public"
    public_ip_address_id          = azurerm_public_ip.vm1_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet1.id
  }
}
