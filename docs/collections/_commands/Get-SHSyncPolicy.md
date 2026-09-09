---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Get-SHSyncPolicy

## SYNOPSIS
Gets sync policies

## SYNTAX

### byQuery (Default)
```
Get-SHSyncPolicy [-filter <String>] [-projection <String>] [-offset <Int32>] [-limit <Int32>]
 [<CommonParameters>]
```

### byId
```
Get-SHSyncPolicy -policyId <String> [-projection <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets the sync policies defined on the tenant - a single policy by identifier, or a list.

A sync policy defines which secrets sync from the source secret store to a target secret store.

The service supports **one filter per call** here, so `-filter` takes a single expression - either `filter.safeName EQ <name>` or `target.id EQ <storeId>`.

`-projection EXTEND` returns the full source, target and filter objects along with the policy's sync status, rather than just their identifiers.

Results are paginated automatically; every page is retrieved and the policies of each are returned.

## EXAMPLES

### Example 1
```
Get-SHSyncPolicy
```

Gets all sync policies

### Example 2
```
Get-SHSyncPolicy -policyId policy-62d19762-85d0-4cc0-ba44-9e0156a5c9c6 -projection EXTEND
```

Gets the specified sync policy with its full source, target and status detail

### Example 3
```
Get-SHSyncPolicy -filter 'filter.safeName EQ MySafeName'
```

Gets the sync policies for the specified Safe

### Example 4
```
Get-SHSyncPolicy -filter 'target.id EQ store-cfd25162-f8a9-4d94-8d36-f46c4b60d651'
```

Gets the sync policies which sync to the specified target secret store

## PARAMETERS

### -policyId
The unique identifier of the sync policy, of the form `policy-<uuid>`.

```yaml
Type: String
Parameter Sets: byId
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filter
A single filter expression - `filter.safeName EQ <name>` or `target.id EQ <storeId>`.

```yaml
Type: String
Parameter Sets: byQuery
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -projection
How much data to return per policy. The service returns `REGULAR` when not specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: EXTEND, REGULAR

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -offset
The number of policies to skip before returning results.

```yaml
Type: Int32
Parameter Sets: byQuery
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The number of policies to return per request, between 1 and 1000. The service returns 100 when not specified.

```yaml
Type: Int32
Parameter Sets: byQuery
Aliases: 

Required: False
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
