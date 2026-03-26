mock_provider "azurerm" {}

# ---------------------------------------------------------------------------
# Shared variables reused across all runs
# env = "ScTc", userDefinedString = "test" → expected name "ScTcCNR-test-vnet"
# ---------------------------------------------------------------------------
variables {
  env               = "ScTc"
  userDefinedString = "test"
  tags              = {}

  resource_groups = {
    Network = {
      name     = "rg-network-test"
      location = "canadacentral"
    }
  }
}

# ---------------------------------------------------------------------------
# naming_convention
# Verifies the VNet name follows {env_4}CNR-{userDefinedString}-vnet convention
# ---------------------------------------------------------------------------
run "naming_convention" {
  command = plan

  variables {
    virtual_network = {
      resource_group = "Network"
      address_space  = ["10.10.0.0/16"]
    }
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "ScTcCNR-test-vnet"
    error_message = "Name must follow {env_4}CNR-{userDefinedString}-vnet convention; got: ${azurerm_virtual_network.vnet.name}"
  }
}

# ---------------------------------------------------------------------------
# default_values
# Plan succeeds with minimal config; resource group resolved from resource_groups map
# ---------------------------------------------------------------------------
run "default_values" {
  command = plan

  variables {
    virtual_network = {
      resource_group = "Network"
      address_space  = ["10.10.0.0/16"]
    }
  }

  assert {
    condition     = azurerm_virtual_network.vnet.resource_group_name == "rg-network-test"
    error_message = "resource_group_name must be resolved from resource_groups map"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.location == "canadacentral"
    error_message = "location must be resolved from resource_groups map"
  }
}

# ---------------------------------------------------------------------------
# with_dns_servers
# dns_servers forwarded correctly from config object
# ---------------------------------------------------------------------------
run "with_dns_servers" {
  command = plan

  variables {
    virtual_network = {
      resource_group = "Network"
      address_space  = ["10.10.0.0/16"]
      dns_servers    = ["10.10.0.4", "10.10.0.5"]
    }
  }

  assert {
    condition     = length(azurerm_virtual_network.vnet.dns_servers) == 2
    error_message = "dns_servers must contain both configured entries"
  }
}

# ---------------------------------------------------------------------------
# with_encryption
# encryption block rendered when encryption_enforcement is set
# ---------------------------------------------------------------------------
run "with_encryption" {
  command = plan

  variables {
    virtual_network = {
      resource_group         = "Network"
      address_space          = ["10.10.0.0/16"]
      encryption_enforcement = "AllowUnencrypted"
    }
  }

  assert {
    condition     = length(azurerm_virtual_network.vnet.encryption) == 1
    error_message = "encryption block must be emitted when encryption_enforcement is provided"
  }
}

# ---------------------------------------------------------------------------
# with_new_args
# flow_timeout_in_minutes and private_endpoint_vnet_policies are set correctly
# ---------------------------------------------------------------------------
run "with_new_args" {
  command = plan

  variables {
    virtual_network = {
      resource_group                 = "Network"
      address_space                  = ["10.10.0.0/16"]
      flow_timeout_in_minutes        = 20
      private_endpoint_vnet_policies = "Basic"
    }
  }

  assert {
    condition     = azurerm_virtual_network.vnet.flow_timeout_in_minutes == 20
    error_message = "flow_timeout_in_minutes must be set to 20"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.private_endpoint_vnet_policies == "Basic"
    error_message = "private_endpoint_vnet_policies must be set to Basic"
  }
}

# ---------------------------------------------------------------------------
# legacy_vars_compat
# Old callers that pass resource_group + address_space as direct vars still work
# ---------------------------------------------------------------------------
run "legacy_vars_compat" {
  command = plan

  variables {
    resource_group = {
      name     = "rg-network-test"
      location = "canadacentral"
    }
    address_space = ["10.10.0.0/16"]
  }

  assert {
    condition     = azurerm_virtual_network.vnet.resource_group_name == "rg-network-test"
    error_message = "Legacy resource_group var must still work"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "ScTcCNR-test-vnet"
    error_message = "Name must be unchanged for legacy callers"
  }
}
