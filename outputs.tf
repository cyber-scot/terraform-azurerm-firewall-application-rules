output "network_rule_collections_output" {
  description = "The network rule collections created by the module."
  value       = azurerm_firewall_network_rule_collection.network_rules
}

output "network_rule_ids" {
  description = "The IDs of the network rule collections."
  value       = { for k, v in azurerm_firewall_network_rule_collection.network_rules : k => v.id }
}

output "network_rule_names" {
  description = "The names of the network rule collections."
  value       = { for k, v in azurerm_firewall_network_rule_collection.network_rules : k => v.name }
}

output "network_rules" {
  description = "Details of the network rules within each collection."
  value       = { for k, v in azurerm_firewall_network_rule_collection.network_rules : k => v.rule }
}
