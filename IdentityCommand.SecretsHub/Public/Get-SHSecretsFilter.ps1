# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Get-SHSecretsFilter {
    [CmdletBinding(DefaultParameterSetName = 'byStore')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$storeId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byId'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$filterId
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId/filters"

        if ($PSCmdlet.ParameterSetName -eq 'byId') {
            $URI = "$URI/$filterId"
        }

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
