resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-vllm-platform"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "vllm-platform"

  kubernetes_version = null

  default_node_pool {
    name           = "system"
    node_count     = 2
    vm_size        = "Standard_D4s_v5"
    vnet_subnet_id = azurerm_subnet.this.id

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    service_cidr = "10.20.0.0/16"
    dns_service_ip = "10.20.0.10"
  }
}
