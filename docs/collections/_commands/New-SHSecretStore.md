---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# New-SHSecretStore

## SYNOPSIS
Creates a secret store

## SYNTAX

```
New-SHSecretStore -type <String> -name <String> -data <Hashtable> [-description <String>]
 [-state <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a secret store in Secrets Hub.

The contents of `-data` depend entirely on `-type` - an AWS store needs an account ID, region and role name, an Azure Key Vault needs a vault URL and application client details, and so on. The module passes the hashtable through as given rather than modelling each vendor's schema.

## EXAMPLES

### Example 1
```
New-SHSecretStore -type AWS_ASM -name 'Account alias - us-east-1' -data @{
    accountAlias = 'my-account-alias'
    accountId    = '123456789012'
    regionId     = 'us-east-1'
    roleName     = 'Secrets-Hub-IAM-Role'
}
```

Creates an AWS Secrets Manager target store

### Example 2
```
New-SHSecretStore -type AZURE_AKV -name 'My Key Vault' -description 'Azure Key Vault for dev-team' -data @{
    appClientDirectoryId = 'c389961d-a0cd-46ab-9f69-877f756a59c1'
    appClientId          = 'c389961d-a0cd-46ab-9f69-877f756a59c1'
    azureVaultUrl        = 'https://example.vault.azure.net'
    connectionConfig     = @{ connectionType = 'PUBLIC' }
}
```

Creates an Azure Key Vault target store

## PARAMETERS

### -type
The type of secret store to create.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: PAM_PCLOUD, PAM_SELF_HOSTED, AWS_ASM, AZURE_AKV, GCP_GSM, HASHICORP_VAULT, HASHICORP_VAULT_ENT

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The secret store name.

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

### -data
The vendor-specific connection details for the store, whose keys depend on `-type`.

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

### -description
A description of the secret store.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -state
The initial state of the secret store. The service creates it `ENABLED` when not specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: ENABLED, DISABLED

Required: False
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
