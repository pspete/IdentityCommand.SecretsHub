# .ExternalHelp IdentityCommand.SecretsHub-help.xml
function Get-SHTransformation {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('id')]
        [String]$transformationId
    )

    begin { }#begin

    process {

        $URI = "$(Resolve-RequestUrl)/api/transformations/$transformationId"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
