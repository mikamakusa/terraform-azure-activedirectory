terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.107.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.52.0"
    }
  }
  required_version = ">= 1.8.5"
}