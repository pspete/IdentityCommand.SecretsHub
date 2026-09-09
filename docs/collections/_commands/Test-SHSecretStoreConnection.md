---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Test-SHSecretStoreConnection

## SYNOPSIS
Gets the connection status of a secret store

## SYNTAX

```
Test-SHSecretStoreConnection -storeId <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the result of the service's connection test against a secret store - a status of `OK` or `ERROR`, with a message giving more detail.

## EXAMPLES

### Example 1
```
Test-SHSecretStoreConnection -storeId store-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Gets the connection status of the specified secret store

### Example 2
```
Get-SHSecretStore | Test-SHSecretStoreConnection | Where-Object status -ne OK
```

Reports every secret store the service cannot connect to

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
