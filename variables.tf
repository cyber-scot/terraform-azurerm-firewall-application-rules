variable "firewall_name" {
  type        = string
  description = "The name of the Azure firewall this rule collection should be added to"
}

variable "network_rule_collections" {
  description = "A list of network rule collections, each containing a list of network rules."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rules = list(object({
      name                  = string
      description           = optional(string)
      destination_addresses = optional(list(string))
      destination_ports     = list(string)
      destination_ip_groups = optional(list(string))
      protocols             = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_fqdns     = optional(list(string))
    }))
  }))
  default = []
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group the Azure firewall resides within"
}
