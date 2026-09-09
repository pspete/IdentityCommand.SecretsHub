---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Remove-SHSecretsFilter

## SYNOPSIS
Deletes a secrets filter

## SYNTAX

```
Remove-SHSecretsFilter -storeId <String> -filterId <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a secrets filter from a source secret store.

Any policies linked to the filter must be deleted first.

> The service marks the secrets filter endpoints as deprecated. Prefer defining the filter inline when creating a policy - `New-SHSyncPolicy -safeName <name>`.

## EXAMPLES

### Example 1
```
Remove-SHSecretsFilter -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4 -filterId filter-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Deletes the specified secrets filter

## PARAMETERS

### -storeId
The identifier of the source secret store.

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

### -filterId
The identifier of the secrets filter to delete.

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
