---
title: "IdentityCommand.SecretsHub Release 0.1"
date: 2026-10-07 00:00:00
version: 0.1.0
tags:
  - Release Notes
  - Connect-SHTenant
  - Get-SHSecretStore
  - New-SHSecretStore
  - Set-SHSecretStore
  - Remove-SHSecretStore
  - Test-SHSecretStoreConnection
  - Set-SHSecretStoreState
  - Get-SHSecret
  - Publish-SHSecret
  - Remove-SHSecret
  - Get-SHSyncPolicy
  - New-SHSyncPolicy
  - Remove-SHSyncPolicy
  - Set-SHSyncPolicyState
  - Get-SHSecretsFilter
  - New-SHSecretsFilter
  - Remove-SHSecretsFilter
  - Start-SHScan
  - Get-SHConfiguration
  - Set-SHConfiguration
  - Get-SHTransformation
  - Get-SHModuleData
---

## [0.1.0]

### Added

- Initial release of `IdentityCommand.SecretsHub`, wrapping the CyberArk Secrets Hub API.
- `Connect-SHTenant`: authenticate to the Secrets Hub service, resolving the service url from a
  shared services subdomain via platform discovery, or from a url supplied directly.
- Secret stores: `Get-SHSecretStore`, `New-SHSecretStore`, `Set-SHSecretStore`,
  `Remove-SHSecretStore`, `Test-SHSecretStoreConnection`, and `Set-SHSecretStoreState` for one store
  or up to 500 together. Listing is filtered with an expression or from criteria, and paginated
  automatically.
- Secrets: `Get-SHSecret` (filtered and paginated), `Publish-SHSecret` to onboard a discovered
  secret to PAM, and `Remove-SHSecret` to delete an unmanaged secret from its target store.
- Sync policies: `Get-SHSyncPolicy`, `New-SHSyncPolicy`, `Remove-SHSyncPolicy` and
  `Set-SHSyncPolicyState`. A policy's secrets filter can be defined inline from a Safe name, or
  reference an existing filter.
- Secrets filters: `Get-SHSecretsFilter`, `New-SHSecretsFilter`, `Remove-SHSecretsFilter`. The
  service marks these endpoints deprecated; prefer defining the filter inline on the policy.
- `Start-SHScan`, `Get-SHConfiguration`, `Set-SHConfiguration`, `Get-SHTransformation`.
- `Get-SHModuleData`: get the module version and session configuration data.

### Fixed

- `ConvertTo-SHFilterString` now accepts the `NEQ` and `GE` operators, confirmed live against
  `/api/secrets` - `HAS` and `LE` remain excluded, still unconfirmed.
- `Get-SHSyncPolicy -projection` now accepts `METADATA`, confirmed live against `/api/policies`
  though undocumented by the spec's `EXTEND`/`REGULAR` enum.
