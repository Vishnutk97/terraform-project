terraform {
  backend "azurerm" {
    resource_group_name = "AZ_RG"
    storage_account_name = "workshopdemostorage8907"
    container_name = "workshopdemotf"
    key = "terraform.tfstate"
  }
}
