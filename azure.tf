provider "azurerm" {
features{}
subscription_id = "c2bd123a-183f-43d5-bf41-c725494e595a"
  tenant_id       = "3180c264-31bc-4113-8f50-b7393a40457b"
}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}
