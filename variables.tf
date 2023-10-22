variable "application_rule_collections" {
  description = "A list of network rule collections, each containing a list of network rules."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rules = list(object({
      name             = string
      description      = optional(string)
      fqdn_tags        = optional(set(string))
      target_fqdns     = optional(list(string))
      source_addresses = optional(list(string))
      source_ip_groups = optional(list(string))
      protocol = optional(list(object({
        port = optional(string)
        type = optional(string)
      })))
    }))
  }))
  default = []
}

variable "firewall_name" {
  type        = string
  description = "The name of the Azure firewall this rule collection should be added to"
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group the Azure firewall resides within"
}
