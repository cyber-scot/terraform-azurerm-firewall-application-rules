resource "azurerm_firewall_application_rule_collection" "application_rules" {
  for_each = { for k, v in var.application_rule_collections : k => v }

  name                = each.value.name
  azure_firewall_name = var.firewall_name
  resource_group_name = var.rg_name
  priority            = each.value.priority
  action              = title(each.value.action)

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name             = rule.value.name
      description      = rule.value.description
      source_addresses = rule.value.source_addresses
      source_ip_groups = rule.value.source_ip_groups
      fqdn_tags        = rule.value.fqdn_tags
      target_fqdns     = rule.value.target_fqdns

      dynamic "protocol" {
        for_each = rule.value.protocol

        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}
