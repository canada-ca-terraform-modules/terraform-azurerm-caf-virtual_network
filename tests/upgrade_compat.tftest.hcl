mock_provider "azurerm" {}

# ---------------------------------------------------------------------------
# Shared variables
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
# Step 1: simulate currently-deployed resource (pre-upgrade inputs, no new args)
# ---------------------------------------------------------------------------
run "baseline_apply" {
  command = apply

  variables {
    virtual_network = {
      resource_group = "Network"
      address_space  = ["10.10.0.0/16"]
    }
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "ScTcCNR-test-vnet"
    error_message = "Baseline apply: unexpected resource name"
  }
}

# ---------------------------------------------------------------------------
# Step 2: plan upgraded config against the baseline state
# All changes must be in-place updates (0 destroys)
# ---------------------------------------------------------------------------
run "upgrade_plan_no_replacement" {
  command = plan

  variables {
    virtual_network = {
      resource_group                 = "Network"
      address_space                  = ["10.10.0.0/16"]
      encryption_enforcement         = "AllowUnencrypted"
      flow_timeout_in_minutes        = 10
      private_endpoint_vnet_policies = "Basic"
    }
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "ScTcCNR-test-vnet"
    error_message = "Resource name must be unchanged after upgrade (would cause destroy+recreate)"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.flow_timeout_in_minutes == 10
    error_message = "flow_timeout_in_minutes must be set in upgraded plan"
  }
}
