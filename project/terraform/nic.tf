resource "azurerm_network_interface" "nw-interface" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_subnet.id
    private_ip_address_allocation = "Dynamic"
     public_ip_address_id          = azurerm_public_ip.example.id

 
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id = azurerm_network_interface.nw-interface.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  
}
resource "azurerm_public_ip" "example" {
  name                = "example-publicip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  tags                = {
    environment = "dev"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "acceptanceTestSecurityGroup1"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}