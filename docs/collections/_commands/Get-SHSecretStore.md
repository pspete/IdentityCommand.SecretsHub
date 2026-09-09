---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Get-SHSecretStore

## SYNOPSIS
Gets secret stores

## SYNTAX

### byQuery (Default)
```
Get-SHSecretStore [-filter <String>] [-offset <Int32>] [-limit <Int32>] [-sort <String>]
 [-search <String>] [<CommonParameters>]
```

### byFilterCriteria
```
Get-SHSecretStore [-FilterCriteria <Hashtable[]>] [-offset <Int32>] [-limit <Int32>] [-sort <String>]
 [-search <String>] [<CommonParameters>]
```

### byId
```
Get-SHSecretStore -storeId <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the secret stores configured in Secrets Hub - a single store by identifier, or a filtered list.

A secret store is either a **source** (`PAM_PCLOUD`, `PAM_SELF_HOSTED`) that secrets sync from, or a **target** (`AWS_ASM`, `AZURE_AKV`, `GCP_GSM`, `HASHICORP_VAULT`, `HASHICORP_VAULT_ENT`) that secrets are scanned in or synced to. There can be only one source secret store per tenant.

The filter expression uses the Secrets Hub query language: clauses of the form `field OPERATOR value`, joined with `AND`. There is no `OR`, and parentheses are not supported. Values containing spaces are quoted.

`-FilterCriteria` builds that expression from clauses given as hashtables with `Field`, `Operator` and `Value` keys, quoting each value correctly - pass raw values and never pre-quote them.

Results are paginated automatically; every page is retrieved and the stores of each are returned.

## EXAMPLES

### Example 1
```
Get-SHSecretStore
```

Gets all secret stores

### Example 2
```
Get-SHSecretStore -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Gets the specified secret store

### Example 3
```
Get-SHSecretStore -filter 'type EQ AWS_ASM'
```

Gets the AWS Secrets Manager stores

### Example 4
```
Get-SHSecretStore -FilterCriteria @(
    @{ Field = 'type'; Operator = 'EQ'; Value = 'AWS_ASM' }
    @{ Field = 'state'; Operator = 'EQ'; Value = 'ENABLED' }
)
```

Gets the enabled AWS Secrets Manager stores, building the filter expression from criteria

### Example 5
```
Get-SHSecretStore -search my-store -sort 'name DESC'
```

Searches for secret stores by name, organization ID or Azure subscription, sorted by name descending

## PARAMETERS

### -storeId
The unique identifier of the secret store, of the form `store-<uuid>`.

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
A filter expression, passed to the service as given. For example `type EQ AWS_ASM`.

Filterable fields include `type`, `name`, `state`, `behaviors`, `creationDetails`, `organizationId`, `totalSecretsCount`, `totalPoliciesCount`, `createdAt`, `scan.status` and the `data.*` fields.

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

### -offset
The number of secret stores to skip before returning results.

```yaml
Type: Int32
Parameter Sets: byQuery, byFilterCriteria
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The number of secret stores to return per request, between 1 and 1000. The service returns 100 when not specified.

```yaml
Type: Int32
Parameter Sets: byQuery, byFilterCriteria
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort
The order to sort the results, for example `name`, `name DESC` or `type ASC`. The service sorts by `name ASC` when not specified.

```yaml
Type: String
Parameter Sets: byQuery, byFilterCriteria
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
A search term applied to store name, organization ID, and Azure subscription ID and name.

```yaml
Type: String
Parameter Sets: byQuery, byFilterCriteria
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
