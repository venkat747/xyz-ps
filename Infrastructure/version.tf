terraform {
required_providers {
azurerm = {
source = "hashicorp/azurerm"
version = "=3.0.0" # Specify the desired version
    }
  }
}

provider "azurerm" {
features {}
}

