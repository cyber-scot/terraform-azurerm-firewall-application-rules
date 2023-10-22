module "rg" {
  source = "cyber-scot/rg/azurerm"

  name     = "rg-${var.short}-${var.loc}-${var.env}-01"
  location = local.location
  tags     = local.tags
}

module "network" {
  source = "cyber-scot/network/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  vnet_name          = "vnet-${var.short}-${var.loc}-${var.env}-01"
  vnet_location      = module.rg.rg_location
  vnet_address_space = ["10.0.0.0/16"]

  subnets = {
    "sn1-${module.network.vnet_name}" = {
      address_prefixes  = ["10.0.3.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
  }
}

module "firewall" {
  source = "cyber-scot/firewall/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  name = "fw-${var.short}-${var.loc}-${var.env}-01"

  create_firewall_subnet               = true
  create_firewall_management_subnet    = true
  create_firewall_management_public_ip = true
  create_firewall_data_public_ip       = true
  vnet_rg_name                         = module.network.vnet_rg_name
  vnet_name                            = module.network.vnet_name

  firewall_subnet_prefixes            = ["10.0.0.0/26"]
  firewall_management_subnet_prefixes = ["10.0.0.64/26"] # Minimum /26

  ip_configuration            = {} # Use module inherited values
  management_ip_configuration = {} # Enables force tunnel mode
}

module "firewall_rules" {
  source = "../../"

  rg_name       = module.firewall.firewall_rg_name
  firewall_name = module.firewall.firewall_name

  network_rule_collections = [
    {
      name     = "network-rules"
      action   = "Allow"
      priority = 100
      rules = [
        {
          name                  = "AllowHTTP"
          protocols             = ["TCP"]
          description           = "Allow HTTP traffic"
          source_addresses      = ["10.0.0.0/16"]
          source_ip_groups      = []
          destination_addresses = ["0.0.0.0/0"]
          destination_ports     = ["80"]
          destination_ip_groups = []
          destination_fqdns     = []
        },
        {
          name                  = "AllowHTTPS"
          protocols             = ["TCP"]
          description           = "Allow HTTPS traffic"
          source_addresses      = ["10.0.0.0/16"]
          source_ip_groups      = []
          destination_addresses = ["0.0.0.0/0"]
          destination_ports     = ["443"]
          destination_ip_groups = []
          destination_fqdns     = []
        },
        {
          name                  = "AllowDNS"
          protocols             = ["UDP"]
          description           = "Allow DNS traffic"
          source_addresses      = ["10.0.0.0/16"]
          source_ip_groups      = []
          destination_addresses = ["0.0.0.0/0"]
          destination_ports     = ["53"]
          destination_ip_groups = []
          destination_fqdns     = []
        }
      ]
    },
  ]
}




