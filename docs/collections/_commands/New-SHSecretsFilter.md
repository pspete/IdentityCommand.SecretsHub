---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# New-SHSecretsFilter

## SYNOPSIS
Creates a secrets filter

## SYNTAX

```
New-SHSecretsFilter -storeId <String> -safeName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a secrets filter against a source secret store, identifying the PAM Safe holding the secrets to sync. Every sync policy needs its own secrets filter.

The only filter type the service supports is `PAM_SAFE`, which the module sends.

> The service marks the secrets filter endpoints as deprecated. Prefer defining the filter inline when creating a policy - `New-SHSyncPolicy -safeName <name>`.

## EXAMPLES

### Example 1
```
New-SHSecretsFilter -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4 -safeName my-safe
```

Creates a secrets filter for the specified PAM Safe

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

### -safeName
The name of the PAM Safe.

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
