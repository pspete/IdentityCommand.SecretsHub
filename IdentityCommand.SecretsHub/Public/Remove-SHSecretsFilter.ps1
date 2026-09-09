# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Remove-SHSecretsFilter {
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
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$filterId
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId/filters/$filterId"

        if ($PSCmdlet.ShouldProcess($filterId, 'Delete Secrets Filter')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
