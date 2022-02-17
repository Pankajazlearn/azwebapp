terraform {
  required_version = ">1.0.0"
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">= 2.90.0"
      }
  }
 backend "azurerm" {
    resource_group_name  = "moda-live-uks-rg"
    storage_account_name = "malditof"
    container_name       = "terraform"
    key                  = "prod.terraform.tfstate"
   }
  }

provider "azurerm" {
  features {
    
  }
}
resource "azurerm_resource_group" "dev" {
  name     = "Terraformrg1"
  location = "uksouth"
}

resource "azurerm_app_service_plan" "dev" {
  name                = "test7121plan"
  location            = "${azurerm_resource_group.dev.location}"
  resource_group_name = "${azurerm_resource_group.dev.name}"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "dev" {
  name                = "test7121app"
  location            = "${azurerm_resource_group.dev.location}"
  resource_group_name = "${azurerm_resource_group.dev.name}"
  app_service_plan_id = "${azurerm_app_service_plan.dev.id}"
}