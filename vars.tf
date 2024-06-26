variable "resource_group" {
  type = list(object({
    id       = number
    location = string
    name     = string
  }))
  default = []
}

variable "virtual_network" {
  type = list(object({
    id                = number
    name              = string
    address_space     = list(string)
    resource_group_id = number
  }))
  default = []
}

variable "subnet" {
  type = list(object({
    id                 = number
    address_prefixes   = list(string)
    name               = string
    resource_group_id  = number
    virtual_network_id = number
  }))
  default = []
}

variable "security_group" {
  type = list(object({
    id                = number
    name              = string
    resource_group_id = number
    security_rule = optional(list(object({
      priority                   = optional(string)
      direction                  = optional(string)
      access                     = optional(string)
      protocol                   = optional(string)
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
    })))
  }))
  default = []
}

variable "security_group_association" {
  type = list(object({
    id                        = number
    network_security_group_id = number
    subnet_id                 = number
  }))
  default = []
}

variable "ad_group" {
  type = list(object({
    id                         = number
    display_name               = string
    administrative_unit_ids    = optional(list(string))
    assignable_to_role         = optional(bool)
    auto_subscribe_new_members = optional(bool)
    behaviors                  = optional(list(string))
    description                = optional(string)
    external_senders_allowed   = optional(bool)
    hide_from_address_lists    = optional(bool)
    hide_from_outlook_clients  = optional(bool)
    mail_enabled               = optional(bool)
    mail_nickname              = optional(string)
    members                    = optional(list(string))
    onpremises_group_type      = optional(string)
    owners                     = optional(list(string))
    prevent_duplicate_names    = optional(bool)
    provisioning_options       = optional(list(string))
    security_enabled           = optional(bool)
    theme                      = optional(string)
    types                      = optional(list(string))
    visibility                 = optional(string)
    writeback_enabled          = optional(bool)
  }))
}

variable "ad_user" {
  type = list(object({
    id                          = number
    display_name                = string
    user_principal_name         = string
    password                    = optional(string)
    account_enabled             = optional(bool)
    age_group                   = optional(string)
    business_phones             = optional(list(string))
    city                        = optional(string)
    company_name                = optional(string)
    consent_provided_for_minor  = optional(string)
    cost_center                 = optional(string)
    country                     = optional(string)
    department                  = optional(string)
    disable_password_expiration = optional(bool)
    disable_strong_password     = optional(bool)
    division                    = optional(string)
    employee_id                 = optional(string)
    employee_type               = optional(string)
    fax_number                  = optional(string)
    force_password_change       = optional(bool)
    given_name                  = optional(string)
    job_title                   = optional(string)
    mail                        = optional(string)
    mail_nickname               = optional(string)
    manager_id                  = optional(string)
    mobile_phone                = optional(string)
    office_location             = optional(string)
    onpremises_immutable_id     = optional(string)
    other_mails                 = optional(list(string))
    postal_code                 = optional(string)
    preferred_language          = optional(string)
    show_in_address_list        = optional(bool)
    state                       = optional(string)
    street_address              = optional(string)
    surname                     = optional(string)
    usage_location              = optional(string)
  }))
  default = []
}

variable "group_member" {
  type = list(object({
    id               = number
    group_object_id  = number
    member_object_id = number
  }))
  default = []
}

variable "application" {
  type = list(object({
    id                             = number
    display_name                   = string
    description                    = optional(string)
    device_only_auth_enabled       = optional(bool)
    fallback_public_client_enabled = optional(bool)
    group_membership_claims        = optional(list(string))
    identifier_uris                = optional(list(string))
    logo_image                     = optional(string)
    marketing_url                  = optional(string)
    notes                          = optional(string)
    oauth2_post_response_required  = optional(bool)
    prevent_duplicate_names        = optional(bool)
    privacy_statement_url          = optional(string)
    service_management_reference   = optional(string)
    sign_in_audience               = optional(string)
    support_url                    = optional(string)
    tags                           = optional(list(string))
    template_id                    = optional(string)
    terms_of_service_url           = optional(string)
    api = optional(list(object({
      known_client_applications      = optional(list(string))
      mapped_claims_enabled          = optional(bool)
      requested_access_token_version = optional(bool)
      oauth2_permission_scope = optional(list(object({
        id                         = string
        admin_consent_description  = optional(string)
        admin_consent_display_name = optional(string)
        enabled                    = optional(bool)
        type                       = optional(string)
        user_consent_description   = optional(string)
        user_consent_display_name  = optional(string)
        value                      = optional(string)
      })), [])
    })), [])
    app_role = optional(list(object({
      allowed_member_types = list(string)
      description          = string
      display_name         = string
      id                   = string
      enabled              = optional(bool)
    })), [])
    feature_tags = optional(list(object({
      custom_single_sign_on = optional(bool)
      enterprise            = optional(bool)
      gallery               = optional(bool)
      hide                  = optional(bool)
    })), [])
    optional_claims = optional(list(object({
      access_token = optional(list(object({
        name                  = optional(string)
        additional_properties = optional(list(string))
        essential             = optional(bool)
        source                = optional(string)
      })), [])
      id_token = optional(list(object({
        name                  = optional(string)
        additional_properties = optional(list(string))
        essential             = optional(bool)
        source                = optional(string)
      })), [])
      saml2_token = optional(list(object({
        name                  = optional(string)
        additional_properties = optional(list(string))
        essential             = optional(bool)
        source                = optional(string)
      })), [])
    })), [])
    public_client = optional(list(object({
      redirect_uris = optional(list(string))
    })), [])
    required_resource_access = optional(list(object({
      resource_app_id = string
      resource_access = list(object({
        type = string
        id   = string
      }))
    })), [])
    single_page_application = optional(list(object({
      redirect_uris = optional(list(string))
    })), [])
    web = optional(list(object({
      homepage_url  = optional(string)
      logout_url    = optional(string)
      redirect_uris = optional(list(string))
      implicit_grant = optional(list(object({
        access_token_issuance_enabled = optional(bool)
        id_token_issuance_enabled     = optional(bool)
      })), [])
    })), [])
  }))
  default = []
}

variable "service_principal" {
  type = list(object({
    id                            = number
    client_id                     = optional(string)
    description                   = optional(string)
    login_url                     = optional(string)
    notes                         = optional(string)
    preferred_single_sign_on_mode = optional(string)
    use_existing                  = optional(bool)
    app_role_assignment_required  = optional(bool)
    account_enabled               = optional(bool)
    alternative_names             = optional(list(string))
    notification_email_addresses  = optional(list(string))
    owners                        = optional(set(string))
    feature_tags = optional(list(object({
      custom_single_sign_on = optional(bool)
      enterprise            = optional(bool)
      gallery               = optional(bool)
      hide                  = optional(bool)
    })), [])
    saml_single_sign_on = optional(list(object({
      relay_state = optional(string)
    })))
  }))
}

variable "ad_domain_services" {
  type = list(object({
    id                        = number
    domain_name               = string
    location                  = number
    name                      = string
    resource_group_name       = number
    sku                       = string
    domain_configuration_type = optional(string)
    filtered_sync_enabled     = optional(string)
    initial_replica_set = optional(list(object({
      subnet_id = string
    })), [])
    secure_ldap = optional(list(object({
      enabled                  = bool
      pfx_certificate          = string
      pfx_certificate_password = string
      external_access_enabled  = optional(bool)
    })), [])
    notifications = optional(list(object({
      additional_recipients = optional(list(string))
      notify_dc_admins      = optional(bool)
      notify_global_admins  = optional(bool)
    })), [])
    security = optional(list(object({
      kerberos_armoring_enabled       = optional(bool)
      kerberos_rc4_encryption_enabled = optional(bool)
      sync_kerberos_passwords         = optional(bool)
      ntlm_v1_enabled                 = optional(bool)
      sync_ntlm_passwords             = optional(bool)
      sync_on_prem_passwords          = optional(bool)
      tls_v1_enabled                  = optional(bool)
    })), [])
  }))
  default = []
}

variable "domain_service_replica_set" {
  type = list(object({
    id                = number
    domain_service_id = number
    resource_group_id = number
    subnet_id         = number
  }))
  default = []
}

variable "domain_service_trust" {
  type = list(object({
    id                     = number
    domain_service_id      = number
    name                   = string
    password               = string
    trusted_domain_dns_ips = list(string)
    trusted_domain_fqdn    = string
  }))
  default = []
}

variable "virtual_network_peering" {
  type = list(object({
    id                           = number
    name                         = string
    remote_virtual_network_id    = number
    resource_group_id            = number
    virtual_network_id           = number
    allow_forwarded_traffic      = optional(bool)
    allow_gateway_transit        = optional(bool)
    allow_virtual_network_access = optional(bool)
    triggers                     = optional(map(string))
    use_remote_gateways          = optional(bool)
  }))
  default = []
}