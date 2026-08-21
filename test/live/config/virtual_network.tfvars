# config/virtual_network.tfvars
# Tracked, ready-to-run fixture for the test/live harness - one representative
# real-usage instance, not a two-code-path engineered fixture and not a
# dormant "_" template.
#
# Mirrors the common landing-zone path: one VNet in the throwaway live-test
# resource group with a single address space. No for_each fan-out - one
# instance is enough to prove a breaking-change gate.
#
# Maintained by whoever adds a new optional input to the module: update this
# file in the same PR if you want live coverage of it, same discipline as
# updating tests/*.tftest.hcl.

env = "livetest"

virtual_network = {
  resource_group = "live_test"
  address_space  = ["10.250.0.0/16"]
}
