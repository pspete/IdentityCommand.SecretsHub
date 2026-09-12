# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Get-SHSyncPolicy {
    [CmdletBinding(DefaultParameterSetName = 'byQuery')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byId'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$policyId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$filter,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('EXTEND', 'REGULAR', 'METADATA')]
        [String]$projection,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [ValidateRange(0, 150000)]
        [int]$offset,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [ValidateRange(1, 1000)]
        [int]$limit
    )

    begin { }#begin

    process {

        if ($PSCmdlet.ParameterSetName -eq 'byId') {

            $URI = "$($ISPSSSession.tenant_url)/api/policies/$policyId"
            $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter -ParametersToRemove policyId)

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method GET

        } else {

            $URI = "$($ISPSSSession.tenant_url)/api/policies"
            $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter)

            #Send Request
            $result = Invoke-IDRestMethod -Uri $URI -Method GET

            if ($null -ne $result) {

                #The policies response reports the tenant total as count, with no separate totalCount
                Get-PagedResult -InitialResult $result -URI $URI -Style Offset -ResultProperty 'policies' -TotalResponseKey 'count'

            }

        }

    }#process

    end { }#end

}
