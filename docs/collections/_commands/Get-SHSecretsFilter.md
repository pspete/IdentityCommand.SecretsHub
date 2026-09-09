---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Get-SHSecretsFilter

## SYNOPSIS
Gets the secrets filters of a secret store

## SYNTAX

### byStore (Default)
```
Get-SHSecretsFilter -storeId <String> [<CommonParameters>]
```

### byId
```
Get-SHSecretsFilter -storeId <String> -filterId <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the secrets filters defined against a source secret store - all of them, or one by identifier.

A secrets filter identifies the object in the source secret store holding the secrets that sync. The only supported filter type is `PAM_SAFE`.

> The service marks the secrets filter endpoints as deprecated. Prefer defining the filter inline when creating a policy - `New-SHSyncPolicy -safeName <name>`.

## EXAMPLES

### Example 1
```
Get-SHSecretsFilter -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Gets all secrets filters of the specified source secret store

### Example 2
```
Get-SHSecretsFilter -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4 -filterId filter-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Gets the specified secrets filter

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
The identifier of a single secrets filter to get.

```yaml
Type: String
Parameter Sets: byId
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
