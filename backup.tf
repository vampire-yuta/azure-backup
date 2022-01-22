resource "azurerm_resource_group" "example" {
  name     = "tfex-recovery_vault"
  location = "japaneast"
}

resource "azurerm_recovery_services_vault" "example" {
  name                = "tfex-recovery-vault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "example" {
  name                = "tfex-recovery-vault-policy"
  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "10:00"
  }

  retention_daily {
    count = 7
  }

  retention_weekly {
    count    = 1
    weekdays = ["Sunday"]
  }

  # retention_monthly {
  #   count    = 7
  #   weekdays = ["Sunday", "Wednesday"]
  #   weeks    = ["First", "Last"]
  # }

  # retention_yearly {
  #   count    = 77
  #   weekdays = ["Sunday"]
  #   weeks    = ["Last"]
  #   months   = ["January"]
  # }
}
