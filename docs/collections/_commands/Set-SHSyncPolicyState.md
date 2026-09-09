---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Set-SHSyncPolicyState

## SYNOPSIS
Enables or disables a sync policy

## SYNTAX

```
Set-SHSyncPolicyState -policyId <String> -action <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enables or disables a sync policy. A disabled policy stops syncing its secrets without being deleted.

## EXAMPLES

### Example 1
```
Set-SHSyncPolicyState -policyId policy-62d19762-85d0-4cc0-ba44-9e0156a5c9c6 -action disable
```

Disables the specified sync policy

### Example 2
```
Get-SHSyncPolicy | Set-SHSyncPolicyState -action disable
```

Disables every sync policy

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

### -action
Whether to enable or disable the policy.

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
