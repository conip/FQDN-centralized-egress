# output "firewalls" {
#     value = module.mc_firenet_aws.aviatrix_firewall_instance[*].gw_name
#     sensitive = true
# }

resource "aviatrix_firewall_tag" "test_firewall_tag" {
  firewall_tag = "my_tag"
}

resource "aviatrix_fqdn" "test_fqdn" {
  fqdn_tag     = "my_tag"
  fqdn_enabled = true
  fqdn_mode    = "white"

  dynamic "gw_filter_tag_list" {
    for_each = module.mc_firenet_aws.aviatrix_firewall_instance[*].gw_name
    content {
      gw_name = gw_filter_tag_list.value
    }
  }

#   dynamic "gw_filter_tag_list" {
#     for_each = module.mc_firenet_az.aviatrix_firewall_instance[*].gw_name
#     content {
#       gw_name = gw_filter_tag_list.value
#     }
#   }


  manage_domain_names = false
}

resource "aviatrix_fqdn_tag_rule" "fqdn1" {
  fqdn_tag_name = "my_tag"
  fqdn          = "wp.pl"
  protocol      = "tcp"
  port          = "443"
}

resource "aviatrix_fqdn_tag_rule" "fqdn2" {
  fqdn_tag_name = "my_tag"
  fqdn          = "ifconfig.me"
  protocol      = "tcp"
  port          = "80"
}

resource "aviatrix_fqdn_tag_rule" "fqdn3" {
  fqdn_tag_name = "my_tag"
  fqdn          = "*.google.com"
  protocol      = "tcp"
  port          = "80"
}

resource "aviatrix_fqdn_tag_rule" "fqdn4" {
  fqdn_tag_name = "my_tag"
  fqdn          = "*.google.com"
  protocol      = "tcp"
  port          = "443"
}
