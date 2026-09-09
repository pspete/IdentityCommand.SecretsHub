# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Set-SHSecretStore {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$storeId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$data,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 200)]
        [String]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 150)]
        [String]$description
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId"

        $body = $PSBoundParameters | Get-Parameter -ParametersToRemove storeId | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($storeId, 'Update Secret Store')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method PATCH -Body $body

        }

    }#process

    end { }#end

}
