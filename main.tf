terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "324ab21b-0045-4562-84eb-01df0f16517c"
  tenant_id       = "c6dbf372-8511-460f-9d8f-863d8256a37d"
  client_id       = "1a83fe70-9fe4-4162-a1e7-7cdc3b2a6cea"
  client_secret   = "E5G8Q~TcneeE-uLQQHjeAggklsU4BPmQhry~Fay7"


}

resource "azurerm_resource_group" "aks_rg" {
  name     = "AZ_rg"
  location = "East US"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "workshopdemostorage8907"
  resource_group_name      = azurerm_resource_group.aks_rg.name
  location                 = azurerm_resource_group.aks_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "workshopdemotf"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "workshop-terraform"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "my-aks-dns-prefix"
  kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2ms"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "1a83fe70-9fe4-4162-a1e7-7cdc3b2a6cea"
    client_secret = "-mJ8Q~MLRjLcEVwg5m1_kIqXcWgNxJg-ZpHhDbSR"
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "workshop"
  }
}
