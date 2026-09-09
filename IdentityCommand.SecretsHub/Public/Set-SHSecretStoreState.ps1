# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Set-SHSecretStoreState {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Single')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Single'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$storeId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Bulk'
        )]
        [ValidateCount(1, 500)]
        [String[]]$secretStoreIds,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('enable', 'disable')]
        [String]$action
    )

    begin { }#begin

    process {

        if ($PSCmdlet.ParameterSetName -eq 'Bulk') {

            $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/states"
            $Target = "$($secretStoreIds.Count) secret stores"
            $body = [ordered]@{ action = $action; secretStoreIds = $secretStoreIds } | ConvertTo-Json -Depth 8

        } else {

            $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId/state"
            $Target = $storeId
            $body = [ordered]@{ action = $action } | ConvertTo-Json -Depth 8

        }

        if ($PSCmdlet.ShouldProcess($Target, "Set Secret Store State: $action")) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method PUT -Body $body

        }

    }#process

    end { }#end

}
