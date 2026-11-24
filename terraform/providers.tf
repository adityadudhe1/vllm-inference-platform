terraform {
  cloud {
    organization = "adityadudhe1"

    workspaces {
      name = "vllm-inference-platform"
    }
  }

  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
