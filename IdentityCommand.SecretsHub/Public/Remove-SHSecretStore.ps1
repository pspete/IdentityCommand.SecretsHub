# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Remove-SHSecretStore {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$storeId
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId"

        if ($PSCmdlet.ShouldProcess($storeId, 'Delete Secret Store')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
