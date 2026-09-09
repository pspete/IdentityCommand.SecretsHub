# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Test-SHSecretStoreConnection {
    [CmdletBinding()]
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

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId/status/connection"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
