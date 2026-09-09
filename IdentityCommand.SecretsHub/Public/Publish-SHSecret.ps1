# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Publish-SHSecret {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('AWS_ASM', 'GCP_GSM', 'AZURE_AKV', 'HASHICORP_VAULT', 'HASHICORP_VAULT_ENT')]
        [String]$sourceSecretStoreType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('PAM_PCLOUD', 'PAM_SELF_HOSTED')]
        [String]$targetSecretStoreType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$secretId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('PLAINTEXT', 'JSON', 'TEMPLATE')]
        [String]$secretValueType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 28)]
        [String]$safeName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$pamAccount
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secrets-onboarding/$sourceSecretStoreType/$targetSecretStoreType"

        $body = $PSBoundParameters | Get-Parameter -ParametersToRemove sourceSecretStoreType, targetSecretStoreType |
            ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($secretId, 'Onboard Secret')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body -Accept $(Get-SHApiHeader)

        }

    }#process

    end { }#end

}
