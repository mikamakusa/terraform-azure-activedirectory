resource "azuread_group" "this" {
  count                      = lenght(var.ad_group)
  display_name               = lookup(var.ad_group[count.index], "display_name")
  administrative_unit_ids    = lookup(var.ad_group[count.index], "administrative_unit_ids")
  assignable_to_role         = lookup(var.ad_group[count.index], "assignable_to_role")
  auto_subscribe_new_members = lookup(var.ad_group[count.index], "auto_subscribe_new_members")
  behaviors                  = lookup(var.ad_group[count.index], "behaviors")
  description                = lookup(var.ad_group[count.index], "description")
  external_senders_allowed   = lookup(var.ad_group[count.index], "external_senders_allowed")
  hide_from_address_lists    = lookup(var.ad_group[count.index], "hide_from_address_lists")
  hide_from_outlook_clients  = lookup(var.ad_group[count.index], "hide_from_outlook_clients")
  mail_enabled               = lookup(var.ad_group[count.index], "mail_enabled")
  mail_nickname              = lookup(var.ad_group[count.index], "mail_nickname")
  members                    = lookup(var.ad_group[count.index], "members")
  onpremises_group_type      = lookup(var.ad_group[count.index], "onpremises_group_type")
  owners                     = lookup(var.ad_group[count.index], "owners")
  prevent_duplicate_names    = lookup(var.ad_group[count.index], "prevent_duplicate_names")
  provisioning_options       = lookup(var.ad_group[count.index], "provisioning_options")
  security_enabled           = lookup(var.ad_group[count.index], "security_enabled")
  theme                      = lookup(var.ad_group[count.index], "theme")
  types                      = lookup(var.ad_group[count.index], "types")
  visibility                 = lookup(var.ad_group[count.index], "visibility")
  writeback_enabled          = lookup(var.ad_group[count.index], "writeback_enabled")
}

resource "azuread_user" "this" {
  count                       = length(var.ad_user)
  display_name                = lookup(var.ad_user[count.index], "display_name")
  user_principal_name         = lookup(var.ad_user[count.index], "user_principal_name")
  password                    = sensitive(lookup(var.ad_user[count.index], "password"))
  account_enabled             = lookup(var.ad_user[count.index], "account_enabled")
  age_group                   = lookup(var.ad_user[count.index], "age_group")
  business_phones             = lookup(var.ad_user[count.index], "business_phones")
  city                        = lookup(var.ad_user[count.index], "city")
  company_name                = lookup(var.ad_user[count.index], "company_name")
  consent_provided_for_minor  = lookup(var.ad_user[count.index], "consent_provided_for_minor")
  cost_center                 = lookup(var.ad_user[count.index], "cost_center")
  country                     = lookup(var.ad_user[count.index], "country")
  department                  = lookup(var.ad_user[count.index], "department")
  disable_password_expiration = lookup(var.ad_user[count.index], "disable_password_expiration")
  disable_strong_password     = lookup(var.ad_user[count.index], "disable_strong_password")
  division                    = lookup(var.ad_user[count.index], "division")
  employee_id                 = lookup(var.ad_user[count.index], "employee_id")
  employee_type               = lookup(var.ad_user[count.index], "employee_type")
  fax_number                  = lookup(var.ad_user[count.index], "fax_number")
  force_password_change       = lookup(var.ad_user[count.index], "force_password_change")
  given_name                  = lookup(var.ad_user[count.index], "given_name")
  job_title                   = lookup(var.ad_user[count.index], "job_title")
  mail                        = lookup(var.ad_user[count.index], "mail")
  mail_nickname               = lookup(var.ad_user[count.index], "mail_nickname")
  manager_id                  = lookup(var.ad_user[count.index], "manager_id")
  mobile_phone                = lookup(var.ad_user[count.index], "mobile_phone")
  office_location             = lookup(var.ad_user[count.index], "office_location")
  onpremises_immutable_id     = lookup(var.ad_user[count.index], "onpremises_immutable_id")
  other_mails                 = lookup(var.ad_user[count.index], "other_mails")
  postal_code                 = lookup(var.ad_user[count.index], "postal_code")
  preferred_language          = lookup(var.ad_user[count.index], "preferred_language")
  show_in_address_list        = lookup(var.ad_user[count.index], "show_in_address_list")
  state                       = lookup(var.ad_user[count.index], "state")
  street_address              = lookup(var.ad_user[count.index], "street_address")
  surname                     = lookup(var.ad_user[count.index], "surname")
  usage_location              = lookup(var.ad_user[count.index], "usage_location")
}

resource "azuread_group_member" "this" {
  for_each         = (length(var.ad_group) && length(var.ad_user)) == 0 ? 0 : length(var.group_member)
  group_object_id  = element(azuread_group.this.*.id, lookup(var.group_member[count.index], "group_object_id"))
  member_object_id = element(azuread_user.this.*.id, lookup(var.group_member[count.index], "member_object_id"))
}

resource "azuread_application" "this" {
  count                          = length(var.application)
  display_name                   = lookup(var.application[count.index], "display_name")
  description                    = lookup(var.application[count.index], "description")
  device_only_auth_enabled       = lookup(var.application[count.index], "device_only_auth_enabled")
  fallback_public_client_enabled = lookup(var.application[count.index], "fallback_public_client_enabled")
  group_membership_claims        = lookup(var.application[count.index], "group_membership_claims")
  identifier_uris                = lookup(var.application[count.index], "identifier_uris")
  logo_image                     = lookup(var.application[count.index], "logo_image")
  marketing_url                  = lookup(var.application[count.index], "marketing_url")
  notes                          = lookup(var.application[count.index], "notes")
  oauth2_post_response_required  = lookup(var.application[count.index], "oauth2_post_response_required")
  owners                         = [try(data.azuread_client_config.current.object_id)]
  prevent_duplicate_names        = lookup(var.application[count.index], "prevent_duplicate_names")
  privacy_statement_url          = lookup(var.application[count.index], "privacy_statement_url")
  service_management_reference   = lookup(var.application[count.index], "service_management_reference")
  sign_in_audience               = lookup(var.application[count.index], "sign_in_audience")
  support_url                    = lookup(var.application[count.index], "support_url")
  tags                           = lookup(var.application[count.index], "tags")
  template_id                    = lookup(var.application[count.index], "template_id")
  terms_of_service_url           = lookup(var.application[count.index], "terms_of_service_url")

  dynamic "api" {
    for_each = try(lookup(var.application[count.index], "api")) == null ? [] : ["api"]
    content {
      known_client_applications      = lookup(api.value, "known_client_applications")
      mapped_claims_enabled          = lookup(api.value, "mapped_claims_enabled")
      requested_access_token_version = lookup(api.value, "requested_access_token_version")

      dynamic "oauth2_permission_scope" {
        for_each = lookup(api.value, "oauth2_permission_scope") == null ? [] : ["oauth2_permission_scope"]
        content {
          id                         = lookup(oauth2_permission_scope.value, "id")
          admin_consent_description  = lookup(oauth2_permission_scope.value, "admin_consent_description")
          admin_consent_display_name = lookup(oauth2_permission_scope.value, "admin_consent_display_name")
          enabled                    = lookup(oauth2_permission_scope.value, "enabled")
          type                       = lookup(oauth2_permission_scope.value, "type")
          user_consent_description   = lookup(oauth2_permission_scope.value, "user_consent_description")
          user_consent_display_name  = lookup(oauth2_permission_scope.value, "user_consent_display_name")
          value                      = lookup(oauth2_permission_scope.value, "value")
        }
      }
    }
  }

  dynamic "app_role" {
    for_each = try(lookup(var.application[count.index], "app_role")) == null ? [] : ["app_role"]
    content {
      allowed_member_types = lookup(app_role.value, "allowed_member_types")
      description          = lookup(app_role.value, "description")
      display_name         = lookup(app_role.value, "display_name")
      id                   = lookup(app_role.value, "id")
      enabled              = lookup(app_role.value, "enabled")
    }
  }

  dynamic "feature_tags" {
    for_each = try(lookup(var.application[count.index], "feature_tags")) == null ? [] : ["feature_tags"]
    content {
      custom_single_sign_on = lookup(feature_tags.value, "custom_single_sign_on")
      enterprise            = lookup(feature_tags.value, "enterprise")
      gallery               = lookup(feature_tags.value, "gallery")
      hide                  = lookup(feature_tags.value, "hide")
    }
  }

  dynamic "optional_claims" {
    for_each = try(lookup(var.application[count.index], "optional_claims")) == null ? [] : ["optional_claims"]
    content {
      dynamic "access_token" {
        for_each = lookup(optional_claims.value, "access_token") == null ? [] : ["access_token"]
        content {
          name                  = lookup(access_token.value, "name")
          additional_properties = lookup(access_token.value, "additional_properties")
          essential             = lookup(access_token.value, "essential")
          source                = lookup(access_token.value, "source")
        }
      }

      dynamic "id_token" {
        for_each = lookup(optional_claims.value, "id_token") == null ? [] : ["id_token"]
        content {
          name                  = lookup(id_token.value, "name")
          additional_properties = lookup(id_token.value, "additional_properties")
          essential             = lookup(id_token.value, "essential")
          source                = lookup(id_token.value, "source")
        }
      }

      dynamic "saml2_token" {
        for_each = lookup(optional_claims.value, "saml2_token") == null ? [] : ["saml2_token"]
        content {
          name                  = lookup(saml2_token.value, "name")
          additional_properties = lookup(saml2_token.value, "additional_properties")
          essential             = lookup(saml2_token.value, "essential")
          source                = lookup(saml2_token.value, "source")
        }
      }
    }
  }

  dynamic "public_client" {
    for_each = try(lookup(var.application[count.index], "public_client")) == null ? [] : ["public_client"]
    content {
      redirect_uris = lookup(public_client.value, "redirect_uris")
    }
  }

  dynamic "required_resource_access" {
    for_each = try(lookup(var.application[count.index], "required_resource_access")) == null ? [] : ["required_resource_access"]
    content {
      resource_app_id = lookup(required_resource_access.value, "resource_app_id")

      dynamic "resource_access" {
        for_each = lookup(required_resource_access.value, "resource_access")
        content {
          type = lookup(resource_access.value, "type")
          id   = lookup(resource_access.value, "id")
        }
      }
    }
  }

  dynamic "single_page_application" {
    for_each = try(lookup(var.application[count.index], "single_page_application")) == null ? [] : ["single_page_application"]
    content {
      redirect_uris = lookup(single_page_application.value, "redirect_uris")
    }
  }

  dynamic "web" {
    for_each = try(lookup(var.application[count.index], "web")) == null ? [] : ["web"]
    content {
      homepage_url  = lookup(web.value, "homepage_url")
      logout_url    = lookup(web.value, "logout_url")
      redirect_uris = lookup(web.value, "redirect_uris")

      dynamic "implicit_grant" {
        for_each = lookup(web.value, "implicit_grant") == null ? [] : ["implicit_grant"]
        content {
          access_token_issuance_enabled = lookup(implicit_grant.value, "access_token_issuance_enabled")
          id_token_issuance_enabled     = lookup(implicit_grant.value, "id_token_issuance_enabled")
        }
      }
    }
  }
}

resource "azuread_service_principal" "this" {
  count                         = length(var.application) == 0 ? 0 : length(var.service_principal)
  client_id                     = try(element(azuread_application.this.*.client_id, lookup(var.service_principal[count.index], "client_id")))
  description                   = lookup(var.service_principal[count.index], "description")
  login_url                     = lookup(var.service_principal[count.index], "login_url")
  notes                         = lookup(var.service_principal[count.index], "notes")
  preferred_single_sign_on_mode = lookup(var.service_principal[count.index], "preferred_single_sign_on_mode")
  use_existing                  = lookup(var.service_principal[count.index], "use_existing")
  app_role_assignment_required  = lookup(var.service_principal[count.index], "app_role_assignment_required")
  account_enabled               = lookup(var.service_principal[count.index], "account_enabled")
  alternative_names             = lookup(var.service_principal[count.index], "alternative_names")
  notification_email_addresses  = lookup(var.service_principal[count.index], "notification_email_addresses")
  owners                        = lookup(var.service_principal[count.index], "owners")

  dynamic "feature_tags" {
    for_each = try(lookup(var.service_principal[count.index], "feature_tags")) == null ? [] : ["feature_tags"]
    content {
      custom_single_sign_on = lookup(feature_tags.value, "custom_single_sign_on")
      enterprise            = lookup(feature_tags.value, "enterprise")
      gallery               = lookup(feature_tags.value, "gallery")
      hide                  = lookup(feature_tags.value, "hide")
    }
  }

  dynamic "saml_single_sign_on" {
    for_each = try(lookup(var.service_principal[count.index], "saml_single_sign_on")) == null ? [] : ["saml_single_sign_on"]
    content {
      relay_state = lookup(saml_single_sign_on.value, "realy_state")
    }
  }
}