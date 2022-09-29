provider "azurerm" {
  features {}
version = "=3.0.0"
  subscription_id = "93dddbd7-bfc8-4990-a718-e7a0526574b6"
  client_id       = "ee718a14-4fde-424f-9f8a-bed892fa11b4"
  client_secret   = "UFw8Q~j4FPyjOgAwgKVNUT5wli98Km-7McD3ucpU"
  tenant_id       = "504f8322-f5f3-4cf4-be52-7c550303d146"
}

resource "azurerm_resource_group" "example" {
  name     = "pip-rg"
  location = "West Europe"
}

resource "azurerm_public_ip" "example" {
  name                = "pip-rg"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
}
resource "random_id" "server" {
  keepers = {
    # Generate a new id each time we switch to a new resource
    resource_group = azurerm_resource_group.example.name
  }

  byte_length = 8
}
resource "azurerm_storage_account" "example" {
  name                     = "sa${random_id.server.hex}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}