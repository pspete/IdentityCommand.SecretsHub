function Get-SHApiHeader {
    <#
    .SYNOPSIS
    Returns the Accept header value for the Secrets Hub beta API surface.

    .DESCRIPTION
    Several Secrets Hub endpoints are documented as Beta and require an explicit Accept header on
    every call; a request without it is refused with 406 Not Acceptable. The value is held here so
    the commands which need it do not each carry a copy.

    Pass the returned value to Invoke-IDRestMethod's -Accept parameter.

    .EXAMPLE
    Invoke-IDRestMethod -Uri $URI -Method GET -Accept $(Get-SHApiHeader)

    .OUTPUTS
    String
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param()

    'application/x.secretshub.beta+json'

}
