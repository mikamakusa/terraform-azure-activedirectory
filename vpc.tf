resource "azurerm_resource_group" "this" {
  count    = length(var.resource_group)
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
}

resource "azurerm_virtual_network" "this" {
  count               = length(var.virtual_network)
  address_space       = lookup(var.virtual_network[count.index], "address_space")
  location            = element(azurerm_resource_group.this.*.location, lookup(var.virtual_network[count.index], "resource_group_id"))
  name                = lookup(var.virtual_network[count.index], "name")
  resource_group_name = element(azurerm_resource_group.this.*.name, lookup(var.virtual_network[count.index], "resource_group_id"))
}

resource "azurerm_subnet" "this" {
  count                = length(var.subnet)
  address_prefixes     = lookup(var.subnet[count.index], "address_prefix")
  name                 = lookup(var.subnet[count.index], "name")
  resource_group_name  = element(azurerm_resource_group.this.*.name, lookup(var.subnet[count.index], "resource_group_id"))
  virtual_network_name = element(azurerm_virtual_network.this.*.name, lookup(var.subnet[count.index], "virtual_network_id"))
}

resource "azurerm_network_security_group" "this" {
  count               = length(var.security_group)
  location            = element(azurerm_resource_group.this.*.location, lookup(var.subnet[count.index], "resource_group_id"))
  name                = lookup(var.security_group[count.index], "name")
  resource_group_name = element(azurerm_resource_group.this.*.name, lookup(var.subnet[count.index], "resource_group_id"))

  dynamic "security_rule" {
    for_each = lookup(var.security_group[count.index], "security_rule") == null ? [] : ["security_rule"]
    content {
      name                       = lookup(security_rule.value, "name")
      priority                   = lookup(security_rule.value, "priority")
      direction                  = lookup(security_rule.value, "direction")
      access                     = lookup(security_rule.value, "access")
      protocol                   = lookup(security_rule.value, "protocol")
      source_port_range          = lookup(security_rule.value, "source_port_range")
      destination_port_range     = lookup(security_rule.value, "destination_port_range")
      source_address_prefix      = lookup(security_rule.value, "source_address_prefix")
      destination_address_prefix = lookup(security_rule.value, "destination_address_prefix")
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = length(var.security_group_association)
  network_security_group_id = try(element(azurerm_network_security_group.this.*.id, lookup(var.security_group_association[count.index], "network_security_group_id")))
  subnet_id                 = try(element(azurerm_subnet.this.*.id, lookup(var.security_group_association[count.index], "subnet_id")))
}

resource "azurerm_virtual_network_peering" "this" {
  count                        = (length(var.virtual_network) && length(var.resource_group)) == 0 ? 0 : length(var.virtual_network_peering)
  name                         = lookup(var.virtual_network_peering[count.index], "name")
  remote_virtual_network_id    = try(element(azurerm_virtual_network.this.*.id, lookup(var.virtual_network_peering[count.index], "remote_virtual_network_id")))
  resource_group_name          = try(element(azurerm_resource_group.this.*.name, lookup(var.virtual_network_peering[count.index], "resource_group_id")))
  virtual_network_name         = try(element(azurerm_virtual_network.this.*.id, lookup(var.virtual_network_peering[count.index], "virtual_network_id")))
  allow_forwarded_traffic      = lookup(var.virtual_network_peering[count.index], "allow_forwarded_traffic")
  allow_gateway_transit        = lookup(var.virtual_network_peering[count.index], "allow_gateway_transit")
  allow_virtual_network_access = lookup(var.virtual_network_peering[count.index], "allow_virtual_network_access")
  triggers                     = lookup(var.virtual_network_peering[count.index], "triggers")
  use_remote_gateways          = lookup(var.virtual_network_peering[count.index], "use_remote_gateways")
}