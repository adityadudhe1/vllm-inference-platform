output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "subnet_id" {
  value = azurerm_subnet.this.id
}
