---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Remove-SHSecret

## SYNOPSIS
Deletes an unmanaged secret from its target secret store

## SYNTAX

```
Remove-SHSecret -secretId <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an unmanaged secret from the target secret store it lives in.

This deletes the secret at the vendor, not merely Secrets Hub's record of it. The service requires the `fromTarget` flag to make that explicit, and the module always sends it.

## EXAMPLES

### Example 1
```
Remove-SHSecret -secretId secret-a94a8fe5-ccb1-9ba6-1c4c-0873d391e987982fbbd3
```

Deletes the specified secret from its target secret store

### Example 2
```
Get-SHSecret -FilterCriteria @{ Field = 'name'; Operator = 'CONTAINS'; Value = 'obsolete' } | Remove-SHSecret -WhatIf
```

Shows which secrets would be deleted, without deleting them

## PARAMETERS

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
