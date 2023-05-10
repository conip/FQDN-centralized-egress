
#-------------------------------------- AZ transit + firenet -------------------------------------
module "mc_transit_az_1" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  cloud                  = "Azure"
  cidr                   = "10.51.0.0/23"
  region                 = var.azure_region
  account                = var.avx_ctrl_account_azure
  bgp_ecmp               = true
  local_as_number        = "65051"
  name                   = "${local.env_prefix}-TRANSIT-1"
  enable_transit_firenet = true
  #enable_egress_transit_firenet = true   # for dual TRansit (1 for E/W and 1 for N/S - for this one only)
}

module "mc_firenet_az" {
  version        = "1.3.0"
  source         = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  transit_module = module.mc_transit_az_1
  firewall_image = "aviatrix"
  fw_amount      = 2
}

module "mc_spoke_az_1" {
  source     = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  cloud      = "Azure"
  ha_gw      = false
  account    = var.avx_ctrl_account_azure
  cidr       = "10.151.0.0/16"
  name       = "${local.env_prefix}-az-spoke1"
  region     = var.azure_region
  transit_gw = module.mc_transit_az_1.transit_gateway.gw_name

}

module "spoke_1_vm1" {
  source               = "git::https://github.com/conip/terraform-azure-instance-build-module.git?ref=pkonitz/password"
  name                 = "${local.env_prefix}-az-spoke1-vm1"
  region               = var.azure_region
  rg                   = module.mc_spoke_az_1.vpc.resource_group
  subnet_id            = module.mc_spoke_az_1.vpc.public_subnets[1].subnet_id
  ssh_key              = var.ssh_key
  enable_password_auth = true
  az_linux_password    = "Alamakota$123"
  public_ip            = true
  depends_on = [
    module.mc_spoke_az_1
  ]
}

module "spoke_1_vm2" {
  source               = "git::https://github.com/conip/terraform-azure-instance-build-module.git?ref=pkonitz/password"
  name                 = "${local.env_prefix}-az-spoke1-vm2"
  region               = var.azure_region
  rg                   = module.mc_spoke_az_1.vpc.resource_group
  subnet_id            = module.mc_spoke_az_1.vpc.private_subnets[1].subnet_id
  ssh_key              = var.ssh_key
  enable_password_auth = true
  az_linux_password    = "Alamakota$123"
  public_ip            = false
  depends_on = [
    module.mc_spoke_az_1
  ]
}


#-------------------------------------- AWS transit + firenet -------------------------------------
module "mc_transit_aws_1" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  cloud                  = "AWS"
  cidr                   = "10.52.0.0/23"
  region                 = var.aws_region
  account                = var.avx_ctrl_account_aws
  bgp_ecmp               = true
  local_as_number        = "65052"
  name                   = "${local.env_prefix}-TRANSIT-2"
  enable_transit_firenet = true
  #enable_egress_transit_firenet = true   # for dual TRansit (1 for E/W and 1 for N/S - for this one only)
}

module "mc_firenet_aws" {
  source         = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version        = "1.3.0"
  transit_module = module.mc_transit_aws_1
  firewall_image = "aviatrix"
  fw_amount      = 2
}

# module "mc_spoke_aws_1" {
#   source     = "terraform-aviatrix-modules/mc-spoke/aviatrix"
#   cloud      = "AWS"
#   ha_gw      = false
#   account    = var.avx_ctrl_account_aws
#   cidr       = "10.152.0.0/16"
#   name       = "${local.env_prefix}-aws-spoke1"
#   region     = "eu-west-1"
#   transit_gw = module.mc_transit_aws_1.transit_gateway.gw_name

# }

# # data "template_file" "bastion_spoke1_user_data" {
# #     template = file("${path.module}/scripts/aws_bootstrap.sh")
# #     vars = {
# #         name     = "Spoke1_Bastion"
# #         password = var.bastion_password
# #     }
# # }

# # module "aws_spoke1_bastion" {
# #     source                      = "terraform-aws-modules/ec2-instance/aws"
# #     version                     = "2.21.0"
# #     instance_type               = var.aws_spoke1_bastion_instance_size
# #     name                        = "${var.avx_aws_uk_spoke1_bastion_name}-bastion"
# #     ami                         = data.aws_ami.ubuntu.id
# #     instance_count              = 1
# #     subnet_id                   = module.aws_spoke_1.vpc.public_subnets[0].subnet_id
# #     vpc_security_group_ids      = [module.aws_bastion_nsg.this_security_group_id]
# #     associate_public_ip_address = true
# #     user_data_base64            = base64encode(data.template_file.bastion_spoke1_user_data.rendered)
# #     providers = {
# #         aws = aws.uk
# #     }
# # }

# # #--------------------------------------------------------------------------

module "transit_peerings" {

  source = "terraform-aviatrix-modules/mc-transit-peering/aviatrix"
  #nonesensitive is needed as Dennis change this mode and marked outputs as sensitive which is causing issue now
  transit_gateways = [
    module.mc_transit_aws_1.transit_gateway.gw_name,
    module.mc_transit_az_1.transit_gateway.gw_name
  ]
  # excluded_cidrs = [
  #   "0.0.0.0/0",
  # ]
}

# # #--------------------------------------------------------------------------
