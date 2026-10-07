---
title: Getting Started
subtitle: Install IdentityCommand.SecretsHub and connect to Secrets Hub
---

## Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- An Idira Identity tenant with the Secrets Hub service enabled
- An Account to Access Idira Identity
- The `IdentityCommand` module.

## Install Options

Install from the PowerShell Gallery:

```powershell
Install-Module -Name IdentityCommand.SecretsHub -Scope CurrentUser
```

Or download the [latest release](https://github.com/pspete/IdentityCommand.SecretsHub/releases), unblock and extract the archive, and copy the `IdentityCommand.SecretsHub` folder into a path listed in `$env:PSModulePath`.

## Authentication

The module requires authentication to the Idira Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.SecretsHub`.

The `Connect-SHTenant` command initialises the bearer token used for module operations against the Secrets Hub service.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
# Resolve the Secrets Hub url automatically from the shared services subdomain
Connect-SHTenant -tenant_subdomain sometenant

# Or provide the Secrets Hub tenant url directly
Connect-SHTenant -tenant_url https://sometenant.secretshub.cyberark.cloud
```

Otherwise, provide a credential and `Connect-SHTenant` authenticates to Idira Identity for you - the Identity tenant url is discovered from the same subdomain / url:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-SHTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-SHTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```
