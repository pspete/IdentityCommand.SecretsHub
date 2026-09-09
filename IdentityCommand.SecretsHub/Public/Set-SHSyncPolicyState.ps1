# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Set-SHSyncPolicyState {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$policyId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('enable', 'disable')]
        [String]$action
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/policies/$policyId/state"

        $body = [ordered]@{ action = $action } | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($policyId, "Set Sync Policy State: $action")) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method PUT -Body $body

        }

    }#process

    end { }#end

}
