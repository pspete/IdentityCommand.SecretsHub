# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function New-SHSyncPolicy {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'BySafeName')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 100)]
        [String]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 150)]
        [String]$description,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$sourceId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$targetId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'BySafeName'
        )]
        [ValidateLength(1, 28)]
        [String]$safeName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ByFilterId'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$filterId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('password_only_plain_text')]
        [String]$transformation
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/policies"

        $Policy = [ordered]@{
            name   = $name
            source = @{ id = $sourceId }
            target = @{ id = $targetId }
        }

        if ($PSBoundParameters.ContainsKey('description')) {
            $Policy['description'] = $description
        }

        $Policy['filter'] = if ($PSCmdlet.ParameterSetName -eq 'ByFilterId') {
            @{ id = $filterId }
        } else {
            [ordered]@{ type = 'PAM_SAFE'; data = @{ safeName = $safeName } }
        }

        if ($PSBoundParameters.ContainsKey('transformation')) {
            $Policy['transformation'] = @{ predefined = $transformation }
        }

        $body = $Policy | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($name, 'Create Sync Policy')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body

        }

    }#process

    end { }#end

}
