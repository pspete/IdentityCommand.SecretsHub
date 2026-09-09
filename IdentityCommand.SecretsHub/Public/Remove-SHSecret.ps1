# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Remove-SHSecret {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$secretId
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secrets/$secretId"

        #The service requires fromTarget, and documents true as its only accepted value
        $URI = Add-QueryString -URI $URI -Parameter @{ fromTarget = 'true' }

        if ($PSCmdlet.ShouldProcess($secretId, 'Delete Secret From Target Secret Store')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
