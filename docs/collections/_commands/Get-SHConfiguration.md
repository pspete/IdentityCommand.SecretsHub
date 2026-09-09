---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Get-SHConfiguration

## SYNOPSIS
Gets the Secrets Hub configuration

## SYNTAX

```
Get-SHConfiguration [<CommonParameters>]
```

## DESCRIPTION
Gets the tenant's Secrets Hub configuration - the PAM type acting as the secrets source, the authentication identities the service uses to reach each cloud vendor, and the sync settings.

## EXAMPLES

### Example 1
```
Get-SHConfiguration
```

Gets the Secrets Hub configuration

### Example 2
```
(Get-SHConfiguration).authenticationIdentities.aws
```

Gets the AWS role ARNs the service authenticates with

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
