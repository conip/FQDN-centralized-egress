# # output "firewalls" {
# #     value = module.mc_firenet_aws.aviatrix_firewall_instance[*].gw_name
# #     sensitive = true
# # }

# resource "aviatrix_firewall_tag" "test_firewall_tag" {
#   firewall_tag = "my_tag"
# }

# resource "aviatrix_fqdn" "test_fqdn" {
#   fqdn_tag     = "my_tag"
#   fqdn_enabled = true
#   fqdn_mode    = "white"

#   dynamic "gw_filter_tag_list" {
#     for_each = module.mc_firenet_aws.aviatrix_firewall_instance[*].gw_name
#     content {
#       gw_name = gw_filter_tag_list.value
#     }
#   }

#   manage_domain_names = true

#   dynamic "domain_names" {
#     for_each = local.url_list
#     content {
#       fqdn = domain_names.value
#       proto = "tcp"
#       port = "443"
#       action = "Base Policy"
#     }
#   }
# }

# locals {
#   url_list = [
#     "aviatrix.com",
#     "amazon.com",
#     "*.amazon.com",
#     "microsoft.com",
#     "*microsoft.com"
#   ]
# }

# # resource "aviatrix_fqdn_tag_rule" "fqdn1" {
# #   fqdn_tag_name = "my_tag"
# #   fqdn          = "wp.pl"
# #   protocol      = "tcp"
# #   port          = "443"
# # }

# # resource "aviatrix_fqdn_tag_rule" "fqdn2" {
# #   fqdn_tag_name = "my_tag"
# #   fqdn          = ["ifconfig.me", "*.amazon.com"]
# #   protocol      = "tcp"
# #   port          = "80"
# # }

# # resource "aviatrix_fqdn_tag_rule" "fqdn3" {
# #   fqdn_tag_name = "my_tag"
# #   fqdn          = "*.google.com"
# #   protocol      = "tcp"
# #   port          = "80"
# # }

# # resource "aviatrix_fqdn_tag_rule" "fqdn4" {
# #   fqdn_tag_name = "my_tag"
# #   fqdn          = "*.google.com"
# #   protocol      = "tcp"
# #   port          = "443"
# # }
# # #   Installs basic Aviatrix gateway

# # module "fqdn_1" {

# #   source             = "./fqdn"
# #   account            = var.account
# #   region             = var.region
# #   vpc_id             = var.vpc_id
# #   subnet             = var.subnet
# #   peer_subnet        = var.peer_subnet
# #   fqdn_gw_name       = var.fqdn_gw_name
# #   gw_size            = var.instance_size
# #   peering_ha_gw_size = var.hainstance_size
# # }

# # #   Enabling FQDN on the created gateway

# # resource "aviatrix_fqdn" "demotest1" {
# #   fqdn_tag            = "demotest1"
# #   fqdn_enabled        = true
# #   fqdn_mode           = "white"
# #   manage_domain_names = false
# #   gw_filter_tag_list {
# #     gw_name = var.fqdn_gw_name
# #   }
# #   depends_on = [module.fqdn_1]
# # }


# # locals {
# #   egress_rules = {
# #     tcp = {
# #       "*.aviatrix.com" = "443"
# #       "*.espn.com"     = "80"
# #       "icanhazip.com" = "80"
# #       "ifconfig.me" = "80"
# #       "*ubuntu.com" = "80"
# #       "*ubuntu.com" = "443"
# #     }
# #     udp = {
# #       "dns.google.com" = "53"
# #     }
# #   }
# # }

# # #    Adding FQDN rules
# # resource "aviatrix_fqdn_tag_rule" "tcp" {
# #   for_each      = local.egress_rules.tcp
# #   fqdn_tag_name = aviatrix_fqdn.demotest1.fqdn_tag
# #   fqdn          = each.key
# #   protocol      = "tcp"
# #   port          = each.value
# #   depends_on    = [aviatrix_fqdn.demotest1]
# # }

# # resource "aviatrix_fqdn_tag_rule" "udp" {
# #   for_each      = local.egress_rules.udp
# #   fqdn_tag_name = aviatrix_fqdn.demotest1.fqdn_tag
# #   fqdn          = each.key
# #   protocol      = "udp"
# #   port          = each.value
# #   depends_on    = [aviatrix_fqdn.demotest1]
# # }
