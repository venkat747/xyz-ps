resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = "Dev"
    domain = "zentac"
    techimpl= "notmapped"
  }
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/24"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "zentac-primary"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "zentac-secondary"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.security_group.id
  }

  tags = {
    environment = "Dev"
    domain = "zentac"
    techimpl= "notmapped"
  }
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = var.vnetsecuritygroup
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "testing"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "Dev"
    domain = "zentac"
    techimpl= "notmapped"
  }
}

resource "azurerm_network_interface" "network_interface" {
  name                = var.network_interface
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.virtual_network.id
    private_ip_address_allocation = "Dynamic"
  }
    tags = {
    environment = "Dev"
    domain = "zentac"
    techimpl= "notmapped"
  }

}

resource "azurerm_application_security_group" "application_security_group" {
  name                = var.application_security_group
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags = {
    environment = "Dev"
    domain = "zentac"
    techimpl= "notmapped"
  }
}


resource "azurerm_network_interface_application_security_group_association" "application_security_group_association" {
  network_interface_id          = azurerm_network_interface.network_interface.id
  application_security_group_id = azurerm_application_security_group.network_interface.id
}