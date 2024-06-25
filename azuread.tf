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
  description                    = ""
  device_only_auth_enabled       = true
  fallback_public_client_enabled = true
  group_membership_claims        = []
  identifier_uris                = []
  logo_image                     = ""
  marketing_url                  = ""
  notes                          = ""
  oauth2_post_response_required  = true
  prevent_duplicate_names        = true
  privacy_statement_url          = ""
  service_management_reference   = ""
  sign_in_audience               = ""
  support_url                    = ""
  tags                           = []
  template_id                    = ""
  terms_of_service_url           = ""

  dynamic "api" {
    for_each = ""
    content {
      known_client_applications      = []
      mapped_claims_enabled          = true
      requested_access_token_version = true

      dynamic "oauth2_permission_scope" {
        for_each = ""
        content {
          id                         = ""
          admin_consent_description  = ""
          admin_consent_display_name = ""
          enabled                    = true
          type                       = ""
          user_consent_description   = ""
          user_consent_display_name  = ""
          value                      = ""
        }
      }
    }
  }

  dynamic "app_role" {
    for_each = ""
    content {
      allowed_member_types = []
      description          = ""
      display_name         = ""
      id                   = ""
      enabled              = true
    }
  }

  dynamic "feature_tags" {
    for_each = ""
    content {
      custom_single_sign_on = true
      enterprise            = true
      gallery               = true
      hide                  = true
    }
  }

  dynamic "optional_claims" {
    for_each = ""
    content {
      dynamic "access_token" {
        for_each = ""
        content {
          name                  = ""
          additional_properties = []
          essential             = true
          source                = ""
        }
      }

      dynamic "id_token" {
        for_each = ""
        content {
          name                  = ""
          additional_properties = []
          essential             = true
          source                = ""
        }
      }

      dynamic "saml2_token" {
        for_each = ""
        content {
          name                  = ""
          additional_properties = []
          essential             = true
          source                = ""
        }
      }
    }
  }

  dynamic "public_client" {
    for_each = ""
    content {}
  }

  dynamic "required_resource_access" {
    for_each = ""
    content {
      resource_app_id = ""

      dynamic "resource_access" {
        for_each = ""
        content {
          type = ""
          id   = ""
        }
      }
    }
  }

  dynamic "single_page_application" {
    for_each = ""
    content {}
  }

  dynamic "web" {
    for_each = ""
    content {}
  }
}

resource "azuread_service_principal" "this" {
  count                         = length(var.service_principal)
  client_id                     = ""
  description                   = ""
  login_url                     = ""
  notes                         = ""
  preferred_single_sign_on_mode = ""
  use_existing                  = true
  app_role_assignment_required  = true
  account_enabled               = true
  alternative_names             = []
  notification_email_addresses  = []
  owners                        = []

  dynamic "feature_tags" {
    for_each = ""
    content {
      custom_single_sign_on = true
      enterprise            = true
      gallery               = true
      hide                  = true
    }
  }

  dynamic "saml_single_sign_on" {
    for_each = ""
    content {
      relay_state = ""
    }
  }
}