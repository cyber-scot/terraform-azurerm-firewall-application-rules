
```hcl
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
      name                  = rule.value.name
      description           = rule.value.description
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      fqdn_tags             = rule.value.fqdn_tags
      target_fqdns          = rule.value.target_fqdns

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
| [azurerm_firewall_application_rule_collection.application_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_application_rule_collection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collections"></a> [application\_rule\_collections](#input\_application\_rule\_collections) | A list of network rule collections, each containing a list of network rules. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rules = list(object({<br>      name             = string<br>      description      = optional(string)<br>      fqdn_tags        = optional(set(string))<br>      target_fqdns     = optional(list(string))<br>      source_addresses = optional(list(string))<br>      source_ip_groups = optional(list(string))<br>      protocol = optional(list(object({<br>        port = optional(string)<br>        type = optional(string)<br>      })))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | The name of the Azure firewall this rule collection should be added to | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group the Azure firewall resides within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_rule_collections_output"></a> [application\_rule\_collections\_output](#output\_application\_rule\_collections\_output) | The application rule collections created by the module. |
| <a name="output_application_rule_ids"></a> [application\_rule\_ids](#output\_application\_rule\_ids) | The IDs of the application rule collections. |
| <a name="output_application_rule_names"></a> [application\_rule\_names](#output\_application\_rule\_names) | The names of the application rule collections. |
| <a name="output_application_rules"></a> [application\_rules](#output\_application\_rules) | Details of the application rules within each collection. |
