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
    for_each = try(lookup(var.ad_domain_services[count.index], "initial_replica_set")) == null ? [] : ["initial_replica_set"]
    content {
      subnet_id = try(element(azurerm_subnet.this.*.id, lookup(initial_replica_set.value, "subnet_id")))
    }
  }

  dynamic "secure_ldap" {
    for_each = try(lookup(var.ad_domain_services[count.index], "secure_ldap")) == null ? [] : ["secure_ldap"]
    content {
      enabled                  = lookup(secure_ldap.value, "enabled")
      pfx_certificate          = file(join("/", [path.cwd, "certificates", lookup(secure_ldap.value), "pfx_certificate"]))
      pfx_certificate_password = sensitive(lookup(secure_ldap.value, "pfx_certificate_password"))
      external_access_enabled  = lookup(secure_ldap.value, "external_access_enabled")
    }
  }

  dynamic "notifications" {
    for_each = try(lookup(var.ad_domain_services[count.index], "notifications")) == null ? [] : ["notifications"]
    content {
      additional_recipients = lookup(notifications.value, "additional_recipients")
      notify_dc_admins      = lookup(notifications.value, "notify_dc_admins")
      notify_global_admins  = lookup(notifications.value, "notify_global_admins")
    }
  }

  dynamic "security" {
    for_each = try(lookup(var.ad_domain_services[count.index], "security")) == null ? [] : ["security"]
    content {
      kerberos_armoring_enabled       = lookup(security.value, "kerberos_armoring_enabled")
      kerberos_rc4_encryption_enabled = lookup(security.value, "kerberos_rc4_encryption_enabled")
      sync_kerberos_passwords         = lookup(security.value, "sync_kerberos_passwords")
      ntlm_v1_enabled                 = lookup(security.value, "ntlm_v1_enabled")
      sync_ntlm_passwords             = lookup(security.value, "sync_ntlm_passwords")
      sync_on_prem_passwords          = lookup(security.value, "sync_on_prem_passwords")
      tls_v1_enabled                  = lookup(security.value, "tls_v1_enabled")
    }
  }
}

resource "azurerm_active_directory_domain_service_replica_set" "this" {
  count             = (length(var.resource_group) && length(var.subnet) && length(var.ad_domain_services)) == 0 ? 0 : length(var.domain_service_replica_set)
  domain_service_id = try(element(azurerm_active_directory_domain_service.this.*.id, lookup(var.domain_service_replica_set[count.index], "domain_service_id")))
  location          = try(element(azurerm_resource_group.this.*.location, lookup(var.domain_service_replica_set[count.index], "resource_group_id")))
  subnet_id         = try(element(azurerm_subnet.this.*.id, lookup(var.domain_service_replica_set[count.index], "subnet_id")))
}

resource "azurerm_active_directory_domain_service_trust" "this" {
  count                  = length(var.ad_domain_services) == 0 ? 0 : length(var.domain_service_trust)
  domain_service_id      = try(element(azurerm_active_directory_domain_service.this.*.id, lookup(var.domain_service_trust[count. index], "domain_service_id")))
  name                   = lookup(var.domain_service_trust[count.index], "name")
  password               = sensitive(lookup(var.domain_service_trust[count.index], "password"))
  trusted_domain_dns_ips = lookup(var.domain_service_trust[count.index], "trusted_domain_dns_ips")
  trusted_domain_fqdn    = lookup(var.domain_service_trust[count.index], "trusted_domain_fqdn")
}