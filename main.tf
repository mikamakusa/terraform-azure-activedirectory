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
      external_access_enabled  = true
    }
  }

  dynamic "notifications" {
    for_each = ""
    content {
      additional_recipients = []
      notify_dc_admins = true
      notify_global_admins = true
    }
  }

  dynamic "security" {
    for_each = ""
    content {
      kerberos_armoring_enabled = true
      kerberos_rc4_encryption_enabled = true
      sync_kerberos_passwords = true
      ntlm_v1_enabled = true
      sync_ntlm_passwords = true
      sync_on_prem_passwords = true
      tls_v1_enabled = true
    }
  }
}

resource "azurerm_active_directory_domain_service_replica_set" "this" {
  domain_service_id = ""
  location          = ""
  subnet_id         = ""
}

resource "azurerm_active_directory_domain_service_trust" "this" {
  domain_service_id      = ""
  name                   = ""
  password               = ""
  trusted_domain_dns_ips = []
  trusted_domain_fqdn    = ""
}