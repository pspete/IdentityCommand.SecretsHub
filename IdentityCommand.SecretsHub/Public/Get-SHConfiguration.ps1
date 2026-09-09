# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Get-SHConfiguration {
    [CmdletBinding()]
    param()

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/configuration"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
