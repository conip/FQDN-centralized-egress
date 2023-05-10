
# output "vm1_azure" {
#     value = { 
#      "public_IP" = module.spoke_1_vm1.public_ip.ip_address, 
#      "private_ip" = module.spoke_1_vm1.private_ip 
#      }
# }
# output "vm2_azure" {
#     value = { 
#      "private_ip" = module.spoke_1_vm2.private_ip 
#      }
# }
#----------------------
# data "azurerm_key_vault" "conix-vault" {
#   name                = "conix-vault"
#   resource_group_name = "conix"
# }

# output "vault_uri" {
#   value = data.azurerm_key_vault.conix-vault.vault_uri
# }

# data "azurerm_key_vault_secret" "presharedkey1" {
#   name         = "presharedkey1"
#   key_vault_id = data.azurerm_key_vault.conix-vault.id
# }

# output "secret_value" {
#   value     = data.azurerm_key_vault_secret.presharedkey1.value
#   sensitive = true
  
# }