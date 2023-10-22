
```hcl
resource "azurerm_firewall_network_rule_collection" "network_rules" {
  for_each = { for k, v in var.network_rule_collections : k => v }

  name                = each.value.name
  azure_firewall_name = var.firewall_name
  resource_group_name = var.rg_name
  priority            = each.value.priority
  action              = title(each.value.action)

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      protocols             = upper(rule.value.protocols)
      description           = rule.value.description
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      destination_ip_groups = rule.value.destination_ip_groups
      destination_fqdns     = rule.value.destination_fqdns
    }
  }
}
```
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_network_rule_collection.network_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_network_rule_collection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | The name of the Azure firewall this rule collection should be added to | `string` | n/a | yes |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | A list of network rule collections, each containing a list of network rules. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rules = list(object({<br>      name                  = string<br>      description           = optional(string)<br>      destination_addresses = optional(list(string))<br>      destination_ports     = list(string)<br>      destination_ip_groups = optional(list(string))<br>      protocols             = list(string)<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group the Azure firewall resides within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_rule_collections_output"></a> [network\_rule\_collections\_output](#output\_network\_rule\_collections\_output) | The network rule collections created by the module. |
| <a name="output_network_rule_ids"></a> [network\_rule\_ids](#output\_network\_rule\_ids) | The IDs of the network rule collections. |
| <a name="output_network_rule_names"></a> [network\_rule\_names](#output\_network\_rule\_names) | The names of the network rule collections. |
| <a name="output_network_rules"></a> [network\_rules](#output\_network\_rules) | Details of the network rules within each collection. |
