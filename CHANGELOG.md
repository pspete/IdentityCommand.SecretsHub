# Change Log

All notable changes to this project will be documented in this file.

## Unreleased

- N/A

## [0.2.0] - 2026-10-16

### Added

- Commands find the Secrets Hub service url from the `IdentityCommand` session on first use, so no connection step is needed after `New-IDSession` or `New-IDPlatformToken`. Commands follow a later `New-IDSession` or `New-IDPlatformToken`, and fail after `Close-IDSession` until you authenticate again.

### Changed

- Requires `IdentityCommand` 1.0.1.
- A request refused with 401 because the session token has expired reports `Session expired at <time>:
  authenticate again with New-IDSession or New-IDPlatformToken`. Previously, it reported `Unauthorized. Unauthorized.`.
- CI caches the PowerShell modules it installs, so dependency installs skip the PowerShell Gallery on a cache hit.

### Removed

- `Connect-SHTenant`. Authenticate with `New-IDSession` or `New-IDPlatformToken` from `IdentityCommand` instead.
- `-offset` from `Get-SHSecret`, `Get-SHSecretStore` and `Get-SHSyncPolicy`. Every page is retrieved automatically, and a starting offset returned duplicated and missing items.

## [0.1.0] - 2026-10-07

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

