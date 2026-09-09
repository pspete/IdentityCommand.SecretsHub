# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Get-SHSecretStore {
    [CmdletBinding(DefaultParameterSetName = 'byQuery')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byId'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$storeId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [ValidateLength(1, 2000)]
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
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byFilterCriteria'
        )]
        [ValidateRange(0, 2147483647)]
        [int]$offset,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byFilterCriteria'
        )]
        [ValidateRange(1, 1000)]
        [int]$limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byFilterCriteria'
        )]
        [ValidateLength(1, 100)]
        [String]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byFilterCriteria'
        )]
        [ValidateLength(1, 100)]
        [String]$search
    )

    begin { }#begin

    process {

        if ($PSCmdlet.ParameterSetName -eq 'byId') {

            $URI = "$($ISPSSSession.tenant_url)/api/secret-stores/$storeId"

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method GET

        } else {

            $URI = "$($ISPSSSession.tenant_url)/api/secret-stores"

            $boundParameters = $PSBoundParameters | Get-Parameter -ParametersToRemove FilterCriteria

            if ($PSBoundParameters.ContainsKey('FilterCriteria')) {
                $boundParameters['filter'] = ConvertTo-SHFilterString -Filter $FilterCriteria
            }

            $URI = Add-QueryString -URI $URI -Parameter $boundParameters

            #Send Request
            $result = Invoke-IDRestMethod -Uri $URI -Method GET

            if ($null -ne $result) {

                Get-PagedResult -InitialResult $result -URI $URI -Style Offset -ResultProperty 'secretStores' -TotalResponseKey 'totalCount'

            }

        }

    }#process

    end { }#end

}
