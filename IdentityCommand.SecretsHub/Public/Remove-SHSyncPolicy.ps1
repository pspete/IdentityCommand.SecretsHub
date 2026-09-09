# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Remove-SHSyncPolicy {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$policyId
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/policies/$policyId"

        if ($PSCmdlet.ShouldProcess($policyId, 'Delete Sync Policy')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
