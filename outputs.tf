output "application_rule_collections_output" {
  description = "The application rule collections created by the module."
  value       = azurerm_firewall_application_rule_collection.application_rules
}

output "application_rule_ids" {
  description = "The IDs of the application rule collections."
  value       = { for k, v in azurerm_firewall_application_rule_collection.application_rules : k => v.id }
}

output "application_rule_names" {
  description = "The names of the application rule collections."
  value       = { for k, v in azurerm_firewall_application_rule_collection.application_rules : k => v.name }
}

output "application_rules" {
  description = "Details of the application rules within each collection."
  value       = { for k, v in azurerm_firewall_application_rule_collection.application_rules : k => v.rule }
}
