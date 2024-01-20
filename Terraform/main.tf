terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.73.0"
      skip_provider_registration = "true"
    }
  }
}
 
provider "azurerm" {
  features {
 
  }
}
 
resource "azurerm_resource_group" "netflix-rg" {
  name     = var.resource_group
  location = var.location
}
 
resource "azurerm_container_registry" "acr" {
  name                = "netflixacr"
  resource_group_name = azurerm_resource_group.netflix-rg.name
  location            = azurerm_resource_group.netflix-rg.location
  sku                 = "Premium"
}
 
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "netflixaks"
  location            = azurerm_resource_group.netflix-rg.location
  resource_group_name = azurerm_resource_group.netflix-rg.name
  dns_prefix          = "netflix"
 
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
 
  identity {
    type = "SystemAssigned"
  }
 
  tags     = var.tags
}
 
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}
 
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
 
  sensitive = true
}
 
# resource "azurerm_role_assignment" "role" {
#   principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.acr.id
#   skip_service_principal_aad_check = true
# }
 
  # backend "azurerm" {
  #   resource_group_name = var.backendrg
  #   storage_account_name = var.backendsa
  #   container_name = var.backendcontainer
  #   key = var.backendkey
  # }