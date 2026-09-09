# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function New-SHSecretsFilter {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$storeId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 28)]
        [String]$safeName
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId/filters"

        #PAM_SAFE is the only filter type the service supports
        $body = [ordered]@{ type = 'PAM_SAFE'; data = @{ safeName = $safeName } } | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($safeName, 'Create Secrets Filter')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body

        }

    }#process

    end { }#end

}
