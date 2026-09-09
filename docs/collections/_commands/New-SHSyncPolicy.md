---
external help file: IdentityCommand.SecretsHub-help.xml
Module Name: IdentityCommand.SecretsHub
online version:
schema: 2.0.0
---

# New-SHSyncPolicy

## SYNOPSIS
Creates a sync policy

## SYNTAX

### BySafeName (Default)
```
New-SHSyncPolicy -name <String> -sourceId <String> -targetId <String> -safeName <String>
 [-description <String>] [-transformation <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByFilterId
```
New-SHSyncPolicy -name <String> -sourceId <String> -targetId <String> -filterId <String>
 [-description <String>] [-transformation <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a sync policy, defining which secrets sync from the source secret store (PAM) to a target secret store.

Each policy needs a secrets filter, which identifies the PAM Safe holding the secrets to sync. Give `-safeName` to define the filter inline as part of the policy, or `-filterId` to reference a filter created earlier with `New-SHSecretsFilter`. Defining it inline is the simpler path, and avoids the deprecated filters endpoints.

## EXAMPLES

### Example 1
```
New-SHSyncPolicy -name 'Dev Team1 Policy' -sourceId $sourceStoreId -targetId $targetStoreId -safeName my-safe
```

Creates a sync policy for the secrets in a PAM Safe

### Example 2
```
New-SHSyncPolicy -name 'Dev Team1 Policy' -description 'Syncing from PAM Self Hosted to us-east-1' `
    -sourceId $sourceStoreId -targetId $targetStoreId -safeName my-safe -transformation password_only_plain_text
```

Creates a sync policy which syncs only the password, as plain text

### Example 3
```
New-SHSyncPolicy -name 'Dev Team1 Policy' -sourceId $sourceStoreId -targetId $targetStoreId -filterId $filterId
```

Creates a sync policy referencing an existing secrets filter

## PARAMETERS

### -name
The policy name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
A description of the policy.

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

### -sourceId
The identifier of the secret store the secrets sync from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetId
The identifier of the secret store the secrets sync to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -safeName
The name of the PAM Safe holding the secrets to sync. The secrets filter is defined inline as part of the policy.

```yaml
Type: String
Parameter Sets: BySafeName
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filterId
The identifier of an existing secrets filter to use, of the form `filter-<uuid>`.

```yaml
Type: String
Parameter Sets: ByFilterId
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -transformation
A predefined transformation to apply to the synced secrets.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: password_only_plain_text

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
