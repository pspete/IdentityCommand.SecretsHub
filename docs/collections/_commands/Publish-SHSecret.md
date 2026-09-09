---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Publish-SHSecret

## SYNOPSIS
Onboards a discovered secret to PAM

## SYNTAX

```
Publish-SHSecret -sourceSecretStoreType <String> -targetSecretStoreType <String> -secretId <String>
 -secretValueType <String> -safeName <String> -pamAccount <Hashtable> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Onboards a secret that Secrets Hub discovered in an external secret store into your PAM solution.

One secret is onboarded per call. Candidates are identified by `Get-SHSecret` - a secret with an `onboardData.status` of `CANDIDATE` can be onboarded.

`-pamAccount` describes the PAM account to create. Its `properties` map each account property to either a literal value (`@{ type = 'VALUE'; value = '...' }`) or a reference to a key within the secret (`@{ type = 'KEY_REF'; keyRef = '...' }`).

This endpoint is a Beta API and requires an Accept header, which the module sends for you.

## EXAMPLES

### Example 1
```
Publish-SHSecret -sourceSecretStoreType AWS_ASM -targetSecretStoreType PAM_PCLOUD `
    -secretId secret-a94a8fe5-ccb1-9ba6-1c4c-0873d391e987982fbbd3 `
    -secretValueType PLAINTEXT -safeName my-safe -pamAccount @{
        name                       = 'accountName'
        platformId                 = 'WinServerLocal'
        automaticManagementEnabled = $true
        properties                 = @{
            username = @{ type = 'VALUE'; value = 'example username' }
            address  = @{ type = 'VALUE'; value = 'example address' }
        }
    }
```

Onboards a plaintext secret from AWS Secrets Manager to Privilege Cloud

### Example 2
```
Publish-SHSecret -sourceSecretStoreType AZURE_AKV -targetSecretStoreType PAM_PCLOUD `
    -secretId $secretId -secretValueType JSON -safeName my-safe -pamAccount @{
        name       = 'accountName'
        platformId = 'WinServerLocal'
        properties = @{
            username = @{ type = 'KEY_REF'; keyRef = 'username' }
            password = @{ type = 'KEY_REF'; keyRef = 'password' }
        }
    }
```

Onboards a JSON secret, mapping account properties to keys within it

## PARAMETERS

### -sourceSecretStoreType
The type of secret store the secret is onboarded from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: AWS_ASM, GCP_GSM, AZURE_AKV, HASHICORP_VAULT, HASHICORP_VAULT_ENT

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetSecretStoreType
The PAM solution the secret is onboarded to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: PAM_PCLOUD, PAM_SELF_HOSTED

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secretId
The unique identifier of the secret in Secrets Hub.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secretValueType
How the secret value is structured.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: PLAINTEXT, JSON, TEMPLATE

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -safeName
The name of the PAM Safe to onboard the account into.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pamAccount
The PAM account to create - its name, platform ID, whether the CPM manages it automatically, and its properties.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
