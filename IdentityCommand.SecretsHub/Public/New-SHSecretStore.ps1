# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function New-SHSecretStore {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('PAM_PCLOUD', 'PAM_SELF_HOSTED', 'AWS_ASM', 'AZURE_AKV', 'GCP_GSM', 'HASHICORP_VAULT', 'HASHICORP_VAULT_ENT')]
        [String]$type,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 200)]
        [String]$name,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$data,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 150)]
        [String]$description,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('ENABLED', 'DISABLED')]
        [String]$state
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secret-stores"

        $body = $PSBoundParameters | Get-Parameter | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($name, 'Create Secret Store')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body

        }

    }#process

    end { }#end

}
