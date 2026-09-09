# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Set-SHConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 730)]
        [int]$secretValidity,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [AllowEmptyCollection()]
        [String[]]$gcpReplicationRegion
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/configuration"

        $SyncSettings = [ordered]@{ }

        if ($PSBoundParameters.ContainsKey('secretValidity')) {
            $SyncSettings['secretValidity'] = $secretValidity
        }

        if ($PSBoundParameters.ContainsKey('gcpReplicationRegion')) {
            #An empty list reverts regional replication to GCP's default global replication
            $SyncSettings['gcp'] = @{ secretReplication = @{ regions = @($gcpReplicationRegion) } }
        }

        $body = [ordered]@{ syncSettings = $SyncSettings } | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess('Secrets Hub Configuration', 'Update Configuration')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method PATCH -Body $body

        }

    }#process

    end { }#end

}
