---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Set-SHConfiguration

## SYNOPSIS
Updates the Secrets Hub sync settings

## SYNTAX

```
Set-SHConfiguration [-secretValidity <Int32>] [-gcpReplicationRegion <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the tenant's sync settings.

`-gcpReplicationRegion` sets the regions GCP secrets replicate to. Passing an empty array reverts to GCP's default global replication; omitting the parameter leaves any configured regional replication untouched.

## EXAMPLES

### Example 1
```
Set-SHConfiguration -secretValidity 400
```

Sets synced secrets to be valid for 400 days

### Example 2
```
Set-SHConfiguration -gcpReplicationRegion us-central1, europe-west1
```

Replicates GCP secrets to the specified regions

### Example 3
```
Set-SHConfiguration -gcpReplicationRegion @()
```

Reverts GCP secrets to global replication

## PARAMETERS

### -secretValidity
The number of days a secret is valid after syncing, between 1 and 730.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -gcpReplicationRegion
The GCP regions to replicate secrets to. An empty array reverts to global replication.

```yaml
Type: String[]
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
