# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Start-SHScan {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 1)]
        [Alias('storeId')]
        [String[]]$secretStoresIds,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$type = 'secret-store',

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$id = 'default'
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/scan-definitions/$type/$id/scan"

        $body = [ordered]@{ scope = @{ secretStoresIds = $secretStoresIds } } | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($secretStoresIds -join ', ', 'Trigger Scan')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body -Accept $(Get-SHApiHeader)

        }

    }#process

    end { }#end

}
