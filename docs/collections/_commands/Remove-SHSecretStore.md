---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Remove-SHSecretStore

## SYNOPSIS
Deletes a secret store

## SYNTAX

```
Remove-SHSecretStore -storeId <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a secret store from Secrets Hub.

Any sync policies linked to the store must be deleted first; the service rejects the request with a conflict while policies remain.

## EXAMPLES

### Example 1
```
Remove-SHSecretStore -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Deletes the specified secret store

### Example 2
```
Get-SHSecretStore -filter 'state EQ DISABLED' | Remove-SHSecretStore
```

Deletes every disabled secret store

## PARAMETERS

### -storeId
The unique identifier of the secret store, of the form `store-<uuid>`.

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
