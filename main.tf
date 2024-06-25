resource "azurerm_active_directory_domain_service" "this" {
  count                     = length(var.ad_domain_services)
  domain_name               = lookup(var.ad_domain_services[count.index], "domain_name")
  location                  = element(azurerm_resource_group.this.*.location, lookup(var.ad_domain_services[count.index], "resource_group_id"))
  name                      = lookup(var.ad_domain_services[count.index], "name")
  resource_group_name       = element(azurerm_resource_group.this.*.name, lookup(var.ad_domain_services[count.index], "resource_group_id"))
  sku                       = lookup(var.ad_domain_services[count.index], "sku")
  domain_configuration_type = lookup(var.ad_domain_services[count.index], "domain_configuration_type", null)
  filtered_sync_enabled     = lookup(var.ad_domain_services[count.index], "filtered_sync_enabled", false)

  dynamic "initial_replica_set" {
    for_each = ""
    content {
      subnet_id = ""
    }
  }

  dynamic "secure_ldap" {
    for_each = ""
    content {
      enabled                  = true
      pfx_certificate          = ""
      pfx_certificate_password = ""
    }
  }

  dynamic "notifications" {
    for_each = ""
    content {

    }
  }

  dynamic "security" {
    for_each = ""
    content {

    }
  }
}