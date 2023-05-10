terraform {
  cloud {
    organization = "CONIX"

    workspaces {
      name = "FQDN-centralized-egress"
    }
  }

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
    }

    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
    }
  }
}