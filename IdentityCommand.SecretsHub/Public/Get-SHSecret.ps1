# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Get-SHSecret {
    [CmdletBinding(DefaultParameterSetName = 'byQuery')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$filter,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byFilterCriteria'
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable[]]$FilterCriteria,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('EXTEND', 'REGULAR')]
        [String]$projection,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(0, 150000)]
        [int]$offset,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 1000)]
        [int]$limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 100)]
        [String]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 200)]
        [String]$search
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/secrets"

        $boundParameters = $PSBoundParameters | Get-Parameter -ParametersToRemove FilterCriteria

        if ($PSBoundParameters.ContainsKey('FilterCriteria')) {
            $boundParameters['filter'] = ConvertTo-SHFilterString -Filter $FilterCriteria
        }

        $URI = Add-QueryString -URI $URI -Parameter $boundParameters

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET -Accept $(Get-SHApiHeader)

        if ($null -ne $result) {

            Get-PagedResult -InitialResult $result -URI $URI -Style Offset -ResultProperty 'secrets' -TotalResponseKey 'totalCount'

        }

    }#process

    end { }#end

}
