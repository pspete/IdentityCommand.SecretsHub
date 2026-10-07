# IdentityCommand.SecretsHub

**IdentityCommand.SecretsHub** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **CyberArk Secrets Hub API** from within the PowerShell environment.

| Main Branch              | CodeFactor                 | Coverage                     | PowerShell Gallery        | License                      |
| ------------------------ | -------------------------- | ---------------------------- | ------------------------- | ---------------------------- |
| [![build][]][build-site] | [![codefactor][]][cf-site] | [![codecov][]][codecov-link] | [![psgallery][]][ps-site] | [![license][]][license-link] |

[build]: https://github.com/pspete/IdentityCommand.SecretsHub/actions/workflows/ci.yml/badge.svg?branch=main&event=push
[build-site]: https://github.com/pspete/IdentityCommand.SecretsHub/actions/workflows/ci.yml?query=branch%3Amain
[psgallery]: https://img.shields.io/powershellgallery/v/IdentityCommand.SecretsHub.svg
[ps-site]: https://www.powershellgallery.com/packages/IdentityCommand.SecretsHub
[downloads]: https://img.shields.io/powershellgallery/dt/IdentityCommand.SecretsHub.svg?color=blue
[cf-site]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.SecretsHub
[codefactor]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.SecretsHub/badge
[codecov]: https://codecov.io/gh/pspete/IdentityCommand.SecretsHub/branch/main/graph/badge.svg
[codecov-link]: https://codecov.io/gh/pspete/IdentityCommand.SecretsHub
[license]: https://img.shields.io/github/license/pspete/IdentityCommand.SecretsHub.svg
[license-link]: https://github.com/pspete/IdentityCommand.SecretsHub/blob/main/LICENSE

## Using the Module

The module requires authentication to the CyberArk Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.SecretsHub`.

### Secrets Hub Authentication

The `Connect-SHTenant` command initialises the bearer token used for module operations against the Secrets Hub service.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
# Resolve the Secrets Hub url automatically from the shared services subdomain
Connect-SHTenant -tenant_subdomain sometenant

# Or provide the Secrets Hub tenant url directly
Connect-SHTenant -tenant_url https://sometenant.secretshub.cyberark.cloud
```

Otherwise, provide a credential and `Connect-SHTenant` authenticates to CyberArk Identity for you - the Identity tenant url is discovered from the same subdomain / url:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-SHTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-SHTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```

### Secret Stores

A secret store is either the **source** the secrets sync from (`PAM_PCLOUD`, `PAM_SELF_HOSTED` - one per tenant) or a **target** they are scanned in and synced to (`AWS_ASM`, `AZURE_AKV`, `GCP_GSM`, `HASHICORP_VAULT`, `HASHICORP_VAULT_ENT`):

```powershell
# All stores, or one by id
Get-SHSecretStore
Get-SHSecretStore -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4

# Filtered, either with an expression or from criteria
Get-SHSecretStore -filter 'type EQ AWS_ASM'
Get-SHSecretStore -FilterCriteria @(
    @{ Field = 'type'; Operator = 'EQ'; Value = 'AWS_ASM' }
    @{ Field = 'state'; Operator = 'EQ'; Value = 'ENABLED' }
)
```

The connection details of a store depend on its type, so they travel as a hashtable:

```powershell
New-SHSecretStore -type AWS_ASM -name 'Account alias - us-east-1' -data @{
    accountAlias = 'my-account-alias'
    accountId    = '123456789012'
    regionId     = 'us-east-1'
    roleName     = 'Secrets-Hub-IAM-Role'
}

Set-SHSecretStore -storeId $storeId -description 'Updated description'
Test-SHSecretStoreConnection -storeId $storeId
Remove-SHSecretStore -storeId $storeId
```

Stores are enabled and disabled one at a time, or up to 500 together - the bulk form reports a result per store, so a partial success is normal:

```powershell
Set-SHSecretStoreState -storeId $storeId -action disable

(Set-SHSecretStoreState -secretStoreIds $Ids -action enable).results | Where-Object result -eq FAILURE
```

### Secrets

`Get-SHSecret` returns what the scans have discovered:

```powershell
Get-SHSecret

# The Secrets Hub query language: clauses joined with AND, no OR, no parentheses
Get-SHSecret -filter 'storeName CONTAINS prod'

# Or build the expression from criteria - values are quoted for you
Get-SHSecret -FilterCriteria @(
    @{ Field = 'vendorType'; Operator = 'EQ'; Value = 'AWS' }
    @{ Field = 'onboardData.status'; Operator = 'EQ'; Value = 'CANDIDATE' }
)

# Vendor-specific data - tags, rotation metadata, regions
Get-SHSecret -projection EXTEND
```

A discovered secret that is a candidate can be onboarded into PAM, and an unmanaged secret can be deleted from the target store it lives in:

```powershell
Publish-SHSecret -sourceSecretStoreType AWS_ASM -targetSecretStoreType PAM_PCLOUD `
    -secretId $secretId -secretValueType PLAINTEXT -safeName my-safe -pamAccount @{
        name                       = 'accountName'
        platformId                 = 'WinServerLocal'
        automaticManagementEnabled = $true
        properties                 = @{
            username = @{ type = 'VALUE'; value = 'example username' }
            password = @{ type = 'KEY_REF'; keyRef = 'password' }
        }
    }

Remove-SHSecret -secretId $secretId
```

### Sync Policies

A sync policy defines which secrets sync from the source store to a target store. Each needs a secrets filter naming the PAM Safe; giving `-safeName` defines it inline and avoids the deprecated filters endpoints:

```powershell
New-SHSyncPolicy -name 'Dev Team1 Policy' -sourceId $sourceStoreId -targetId $targetStoreId -safeName my-safe

Get-SHSyncPolicy
Get-SHSyncPolicy -filter 'filter.safeName EQ MySafeName'
Get-SHSyncPolicy -policyId $policyId -projection EXTEND

Set-SHSyncPolicyState -policyId $policyId -action disable
Remove-SHSyncPolicy -policyId $policyId
```

### Scans, Configuration and Transformations

```powershell
Start-SHScan -secretStoresIds $storeId

Get-SHConfiguration
Set-SHConfiguration -secretValidity 400
Set-SHConfiguration -gcpReplicationRegion us-central1, europe-west1

Get-SHTransformation -transformationId $transformationId
```

## Module Commands

| Command                        | Description                                          |
| ------------------------------ | ---------------------------------------------------- |
| `Connect-SHTenant`             | Authenticate to the Secrets Hub service              |
| `Get-SHSecretStore`            | Get secret stores                                    |
| `New-SHSecretStore`            | Create a secret store                                |
| `Set-SHSecretStore`            | Update a secret store                                |
| `Remove-SHSecretStore`         | Delete a secret store                                |
| `Set-SHSecretStoreState`       | Enable or disable secret stores                      |
| `Test-SHSecretStoreConnection` | Get the connection status of a secret store          |
| `Get-SHSecret`                 | Get the scanned secrets                              |
| `Publish-SHSecret`             | Onboard a discovered secret to PAM                   |
| `Remove-SHSecret`              | Delete an unmanaged secret from its target store     |
| `Get-SHSyncPolicy`             | Get sync policies                                    |
| `New-SHSyncPolicy`             | Create a sync policy                                 |
| `Remove-SHSyncPolicy`          | Delete a sync policy                                 |
| `Set-SHSyncPolicyState`        | Enable or disable a sync policy                      |
| `Get-SHSecretsFilter`          | Get the secrets filters of a secret store            |
| `New-SHSecretsFilter`          | Create a secrets filter                              |
| `Remove-SHSecretsFilter`       | Delete a secrets filter                              |
| `Start-SHScan`                 | Trigger a scan of a secret store                     |
| `Get-SHConfiguration`          | Get the Secrets Hub configuration                    |
| `Set-SHConfiguration`          | Update the Secrets Hub sync settings                 |
| `Get-SHTransformation`         | Get a transformation                                 |
| `Get-SHModuleData`             | Get the module version & session configuration data  |

## Installation

### Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- A CyberArk Identity tenant with the Secrets Hub service enabled
- An Account to Access CyberArk Identity

### Install Options

Users can install IdentityCommand.SecretsHub from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name IdentityCommand.SecretsHub -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `IdentityCommand.SecretsHub`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/IdentityCommand.SecretsHub/):
  - Run the PowerShell command `Save-Module -Name IdentityCommand.SecretsHub -Path C:\temp`
  - Copy the `C:\temp\IdentityCommand.SecretsHub` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.SecretsHub Release

- [Download the latest GitHub release](https://github.com/pspete/IdentityCommand.SecretsHub/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `IdentityCommand.SecretsHub-v#.#.#` folder to `IdentityCommand.SecretsHub`
  - Copy the `IdentityCommand.SecretsHub` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.SecretsHub Branch

- [Download the `main` branch](https://github.com/pspete/IdentityCommand.SecretsHub/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `IdentityCommand.SecretsHub` (`\<Archive Root>\IdentityCommand.SecretsHub-main\IdentityCommand.SecretsHub`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable IdentityCommand.SecretsHub

```

Import the module:

```powershell

Import-Module IdentityCommand.SecretsHub

```

List Module Commands:

```powershell

Get-Command -Module IdentityCommand.SecretsHub

```

Get detailed information on specific commands:

```powershell

Get-Help Connect-SHTenant -Full

```

## Sponsorship

Please support continued development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

_IdentityCommand.SecretsHub_ is neither developed nor supported by CyberArk; any official support channels offered by the vendor are not appropriate for seeking help with the _IdentityCommand.SecretsHub_ module.

Help and support should be sought by [opening an issue][new-issue].

[new-issue]: https://github.com/pspete/IdentityCommand.SecretsHub/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspete@pspete.dev">contact us</a> to discuss options.
