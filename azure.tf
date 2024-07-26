provider "azurerm" {
 
}


resource "azurerm_resource_group" "example" {
  name     = example-resources
  location = East US
}
storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
