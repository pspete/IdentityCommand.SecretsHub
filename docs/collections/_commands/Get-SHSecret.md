---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Get-SHSecret

## SYNOPSIS
Gets the scanned secrets

## SYNTAX

### byQuery (Default)
```
Get-SHSecret [-filter <String>] [-projection <String>] [-offset <Int32>] [-limit <Int32>]
 [-sort <String>] [-search <String>] [<CommonParameters>]
```

### byFilterCriteria
```
Get-SHSecret [-FilterCriteria <Hashtable[]>] [-projection <String>] [-offset <Int32>] [-limit <Int32>]
 [-sort <String>] [-search <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets the secrets Secrets Hub has discovered by scanning the secret stores.

The filter expression uses the Secrets Hub query language: clauses of the form `field OPERATOR value`, joined with `AND`. There is no `OR`, and parentheses are not supported. Values containing spaces are quoted.

`-FilterCriteria` builds that expression from clauses given as hashtables with `Field`, `Operator` and `Value` keys, quoting each value correctly - pass raw values and never pre-quote them.

`-projection EXTEND` returns the vendor-specific data for each secret - tags, rotation metadata, regions and so on - alongside the common fields.

This endpoint is a Beta API and requires an Accept header, which the module sends for you.

Results are paginated automatically; every page is retrieved and the secrets of each are returned.

## EXAMPLES

### Example 1
```
Get-SHSecret
```

Gets all scanned secrets

### Example 2
```
Get-SHSecret -FilterCriteria @{ Field = 'name'; Operator = 'CONTAINS'; Value = 'my value' }
```

Gets the secrets whose name contains the given value

### Example 3
```
Get-SHSecret -FilterCriteria @(
    @{ Field = 'vendorType'; Operator = 'EQ'; Value = 'AWS' }
    @{ Field = 'onboardData.status'; Operator = 'EQ'; Value = 'CANDIDATE' }
)
```

Gets the AWS secrets which are candidates for onboarding to PAM

### Example 4
```
Get-SHSecret -projection EXTEND -filter 'storeName CONTAINS prod'
```

Gets the secrets of stores whose name contains prod, with their vendor-specific data

## PARAMETERS

### -filter
A filter expression, passed to the service as given. For example `name CONTAINS "my value"`.

Filterable fields include `name`, `storeName`, `vendorType`, `vendorSubType`, `storeId`, `originId`, `discoveredAt`, `onboardData.status` and the `vendorData.*` fields.

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

### -FilterCriteria
Filter clauses to assemble into a filter expression. Each is a hashtable with `Field`, `Operator` and `Value` keys.

```yaml
Type: Hashtable[]
Parameter Sets: byFilterCriteria
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -projection
How much data to return per secret. `EXTEND` adds the vendor-specific data. The service returns `REGULAR` when not specified.

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
The number of secrets to skip before returning results.

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

### -limit
The number of secrets to return per request, between 1 and 1000. The service returns 100 when not specified.

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

### -sort
The order to sort the results, for example `name DESC` or `vendorType ASC`. The service sorts by `storeName ASC` when not specified.

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

### -search
A free-text search across secret properties. Up to three space-separated terms.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
