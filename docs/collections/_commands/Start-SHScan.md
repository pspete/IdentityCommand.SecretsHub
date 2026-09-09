---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Start-SHScan

## SYNOPSIS
Triggers a scan of a secret store

## SYNTAX

```
Start-SHScan -secretStoresIds <String[]> [-type <String>] [-id <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Triggers a scan of a secret store, returning the identifiers of the scans started.

One secret store is scanned per call. Scan progress is reported on the secret store itself - see the `scan` property returned by `Get-SHSecretStore`.

This endpoint is a Beta API and requires an Accept header, which the module sends for you.

## EXAMPLES

### Example 1
```
Start-SHScan -secretStoresIds store-5a05468b-fa58-4bcf-84e9-62ede8af55f4
```

Triggers a scan of the specified secret store

### Example 2
```
Get-SHSecretStore -filter 'type EQ AWS_ASM' | ForEach-Object { Start-SHScan -secretStoresIds $_.id }
```

Triggers a scan of every AWS Secrets Manager store

## PARAMETERS

### -secretStoresIds
The identifier of the secret store to scan. The service accepts exactly one.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: storeId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
The type of scan definition to trigger.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: secret-store
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
The identifier of the scan definition to trigger.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: default
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
