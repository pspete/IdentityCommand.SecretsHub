---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Set-SHSecretStoreState

## SYNOPSIS
Enables or disables secret stores

## SYNTAX

### Single (Default)
```
Set-SHSecretStoreState -storeId <String> -action <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Set-SHSecretStoreState -secretStoreIds <String[]> -action <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Enables or disables one secret store, or up to 500 in a single call.

The bulk form reports per-store results rather than failing as a whole: the response lists each store with a result of `SUCCESS` or `FAILURE`, so a partial success is normal and worth inspecting.

## EXAMPLES

### Example 1
```
Set-SHSecretStoreState -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4 -action disable
```

Disables the specified secret store

### Example 2
```
Set-SHSecretStoreState -secretStoreIds $Ids -action enable
```

Enables the specified secret stores in a single call

### Example 3
```
(Set-SHSecretStoreState -secretStoreIds $Ids -action enable).results | Where-Object result -eq FAILURE
```

Enables several stores and reports those the service could not enable

## PARAMETERS

### -storeId
The unique identifier of the secret store, of the form `store-<uuid>`.

```yaml
Type: String
Parameter Sets: Single
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secretStoreIds
The identifiers of between 1 and 500 secret stores to act on together.

```yaml
Type: String[]
Parameter Sets: Bulk
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -action
Whether to enable or disable the secret stores.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: enable, disable

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
