# Change Log

All notable changes to this project will be documented in this file.

## Unreleased

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
