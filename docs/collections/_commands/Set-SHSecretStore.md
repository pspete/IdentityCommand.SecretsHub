---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Set-SHSecretStore

## SYNOPSIS
Updates a secret store

## SYNTAX

```
Set-SHSecretStore -storeId <String> [-data <Hashtable>] [-name <String>] [-description <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the name, description or connection details of a secret store. Only the values supplied are changed.

As with `New-SHSecretStore`, the keys of `-data` depend on the store's type.

## EXAMPLES

### Example 1
```
Set-SHSecretStore -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4 -description 'Updated description'
```

Updates the description of the specified secret store

### Example 2
```
Set-SHSecretStore -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4 -data @{ roleName = 'New-Secrets-Hub-Role' }
```

Updates the AWS role the store uses

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

### -data
The vendor-specific connection details to update, whose keys depend on the store type.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
A new name for the secret store.

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

### -description
A new description for the secret store.

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
