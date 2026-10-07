---
title: IdentityCommand.SecretsHub
subtitle: PowerShell for Idira Secrets Hub
hide_hero: true
---

<div class="has-text-centered mb-6">
  <img src="{{ '/SecretsHub/media/images/IdentityCommand.SecretsHub.png' | relative_url }}" alt="IdentityCommand.SecretsHub" width="471">
</div>

**IdentityCommand.SecretsHub** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **Idira Secrets Hub API** from within the PowerShell environment.

It builds on [IdentityCommand]({{ '/' | relative_url }}) for authentication - see [Getting Started]({{ '/SecretsHub/getting-started/' | relative_url }}) to install and connect, and the [command reference]({{ '/SecretsHub/commands/' | relative_url }}) for every command.

## Secret Stores

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

## Secrets

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

## Sync Policies

A sync policy defines which secrets sync from the source store to a target store. Each needs a secrets filter naming the PAM Safe; giving `-safeName` defines it inline and avoids the deprecated filters endpoints:

```powershell
New-SHSyncPolicy -name 'Dev Team1 Policy' -sourceId $sourceStoreId -targetId $targetStoreId -safeName my-safe

Get-SHSyncPolicy
Get-SHSyncPolicy -filter 'filter.safeName EQ MySafeName'
Get-SHSyncPolicy -policyId $policyId -projection EXTEND

Set-SHSyncPolicyState -policyId $policyId -action disable
Remove-SHSyncPolicy -policyId $policyId
```

## Scans, Configuration and Transformations

```powershell
Start-SHScan -secretStoresIds $storeId

Get-SHConfiguration
Set-SHConfiguration -secretValidity 400
Set-SHConfiguration -gcpReplicationRegion us-central1, europe-west1

Get-SHTransformation -transformationId $transformationId
```
