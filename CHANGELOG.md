# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

## [2.1.0] - 2026-08-04
### Added
- Optional explicit VNet name override support through `virtual_network.name` (ESLZ object style) and legacy `name` input.
- Expanded mock-provider test coverage for all optional `azurerm_virtual_network` arguments exposed by this module (`bgp_community`, `edge_zone`, `ddos_protection_plan`, `flow_timeout_in_minutes`, `private_endpoint_vnet_policies`, `dns_servers`, and `encryption`).
- Required repository artifacts for ESLZ upgrades: `.tflint.hcl`, `.gitattributes`, `.github/workflows/terraform-ci.yml`, and `.github/workflows/release.yml`.

### Changed
- Upgraded azurerm provider constraint to `~> 5.0` (targeting azurerm `v5.0.1`).
- Bumped ESLZ module source pin to `ref=v2.1.0` in `ESLZ/virtual-network.tf`.
- Updated workflow action versions to current tags and standardized `.gitignore` to include `*.tfvars` before `!ESLZ/*.tfvars`.

### Removed
- None.

### Known blockers
- None.
