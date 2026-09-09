---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# Get-SHTransformation

## SYNOPSIS
Gets a transformation

## SYNTAX

```
Get-SHTransformation -transformationId <String> [<CommonParameters>]
```

## DESCRIPTION
Gets a transformation by identifier.

A transformation describes how a secret is reshaped as it syncs - the name it takes in the target store, how its value is structured, and the tags applied to it. Transformations are either predefined by the service or custom to the tenant.

Transformation identifiers appear on a sync policy - see the `transformation` property returned by `Get-SHSyncPolicy`.

## EXAMPLES

### Example 1
```
Get-SHTransformation -transformationId trns-1111dcf3-f6d5-4da4-bb0f-f95ee9898b9f
```

Gets the specified transformation

### Example 2
```
Get-SHSyncPolicy -policyId $policyId | Get-SHTransformation
```

Gets the transformation applied by a sync policy

## PARAMETERS

### -transformationId
The unique identifier of the transformation, of the form `trns-<uuid>`.

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
