---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Remove-SHSyncPolicy

## SYNOPSIS
Deletes a sync policy

## SYNTAX

```
Remove-SHSyncPolicy -policyId <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a sync policy.

The policy's secrets filter is not deleted with it. Where the filter was created separately, delete it afterwards with `Remove-SHSecretsFilter`.

## EXAMPLES

### Example 1
```
Remove-SHSyncPolicy -policyId policy-62d19762-85d0-4cc0-ba44-9e0156a5c9c6
```

Deletes the specified sync policy

### Example 2
```
Get-SHSyncPolicy -filter 'target.id EQ store-cfd25162-f8a9-4d94-8d36-f46c4b60d651' | Remove-SHSyncPolicy
```

Deletes every sync policy targeting the specified secret store

## PARAMETERS

### -policyId
The unique identifier of the sync policy.

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
