run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "Active_Directory" {
  command = [init,plan,apply]

  variables {
    resource_group = [
      {
        id       = 0
        name     = "aadds-1-rg"
        location = "West Europe"
      },
      {
        id       = 1
        name     = "aadds-rg"
        location = "westeurope"
      },
      {
        id       = 2
        name     = "aadds-replica-rg"
        location = "westeurope"
      }
    ]
    virtual_network = [
      {
        id                  = 0
        name                = "aadds-vnet-1"
        resource_group_id   = 0
        address_space       = ["10.0.1.0/16"]
      },
      {
        id                  = 1
        name                = "aadds-vnet-2"
        resource_group_id   = 2
        address_space       = ["11.0.1.0/16"]
      }
    ]
    subnet = [
      {
        id                   = 0
        name                 = "aadds-subnet-1"
        resource_group_id    = 0
        virtual_network_id   = 0
        address_prefixes     = ["10.0.1.0/24"]
      },
      {
        id                   = 1
        name                 = "aadds-subnet-2"
        resource_group_id    = 2
        virtual_network_id   = 1
        address_prefixes     = ["11.0.1.0/24"]
      }
    ]
    security_group_association = [
      {
        id                        = 0
        subnet_id                 = 0
        network_security_group_id = 0
      },
      {
        id                        = 1
        subnet_id                 = 1
        network_security_group_id = 1
      }
    ]
    ad_group = [
      {
        id                = 0
        display_name      = "Administrators"
        security_enabled  = true
      },
      {
        id                = 1
        display_name      = "Users"
        security_enabled  = true
      }
    ]
    ad_users = [
      {
        id                  = 0
        user_principal_name = "admin@example.net"
        display_name        = "DC Administrator"
        password            = "Pa55w0Rd!!1"
      },
      {
        id                  = 1
        user_principal_name = "mike@example.net"
        display_name        = "Mike"
        password            = "Pa55w0Rd!!1"
      }
    ]
    group_member = [
      {
        id                = 0
        group_object_id   = 0
        member_object_id  = 0
      },
      {
        id                = 1
        group_object_id   = 1
        member_object_id  = 1
      }
    ]
    service_principal = [
      {
        id              = 0
        application_id  = "...."
      }
    ]
    security_group = [
      {
        id                = 0
        name              = "aadds-nsg-1"
        resource_group_id = 0
        security_rule = [
          {
            name                       = "AllowSyncWithAzureAD"
            priority                   = 101
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "443"
            source_address_prefix      = "AzureActiveDirectoryDomainServices"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowRD"
            priority                   = 201
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "3389"
            source_address_prefix      = "CorpNetSaw"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowPSRemoting"
            priority                   = 301
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "5986"
            source_address_prefix      = "AzureActiveDirectoryDomainServices"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowLDAPS"
            priority                   = 401
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "636"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      },
      {
        id                = 1
        name              = "aadds-nsg-1"
        resource_group_id = 2
        security_rule = [
          {
            name                       = "AllowSyncWithAzureAD"
            priority                   = 101
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "443"
            source_address_prefix      = "AzureActiveDirectoryDomainServices"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowRD"
            priority                   = 201
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "3389"
            source_address_prefix      = "CorpNetSaw"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowPSRemoting"
            priority                   = 301
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "5986"
            source_address_prefix      = "AzureActiveDirectoryDomainServices"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowLDAPS"
            priority                   = 401
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "636"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      }
    ]
    ad_domain_services = [
      {
        id                    = 0
        name                  = "example-aadds"
        resource_group_id     = 1
        domain_name           = "example.net"
        sku                   = "Enterprise"
        filtered_sync_enabled = false
        initial_replica_set = [
          {
            subnet_id = 0
          }
        ]
        notifications = [
          {
            additional_recipients = ["notifyA@example.net", "notifyB@example.org"]
            notify_dc_admins      = true
            notify_global_admins  = true
          }
        ]
        security = [
          {
            sync_kerberos_passwords = true
            sync_ntlm_passwords     = true
            sync_on_prem_passwords  = true
          }
        ]
      }
    ]
    virtual_network_peering = [
      {
        id                           = 0
        name                         = "aadds-primary-replica"
        resource_group_id            = 0
        virtual_network_id           = 0
        remote_virtual_network_id    = 1
        allow_forwarded_traffic      = true
        allow_gateway_transit        = false
        allow_virtual_network_access = true
        use_remote_gateways          = false
      },
      {
        id                           = 0
        name                         = "aadds-replica-primary"
        resource_group_id            = 2
        virtual_network_id           = 1
        remote_virtual_network_id    = 0
        allow_forwarded_traffic      = true
        allow_gateway_transit        = false
        allow_virtual_network_access = true
        use_remote_gateways          = false
      }
    ]
    domain_service_replica_set = [
      {
        id                = 0
        domain_service_id = 0
        resource_group_id = 1
        subnet_id         = 1
      }
    ]
  }
}