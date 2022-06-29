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
      version = "=2.99"
    }

    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "2.22.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~>3.0.0"
    }

    # test with local added here
  }
}

