BeforeAll {
    $Script:SHModuleName = 'IdentityCommand.SecretsHub'

    #Get Current Directory
    $Here = Split-Path -Parent $PSCommandPath

    #Resolve Path to Module Directory
    $ModulePath = Resolve-Path "$Here\..\$Script:SHModuleName"

    #Define Path to Module Manifest
    $ManifestPath = Join-Path "$ModulePath" "$Script:SHModuleName.psd1"

    if ( -not (Get-Module -Name $Script:SHModuleName -All)) {

        Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

    }
}

Describe 'Get-SHSecret' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{
                'secrets'    = @([pscustomobject]@{ id = 'secret-1'; name = 'my-secret' })
                'count'      = 1
                'totalCount' = 1
            }
        }

        InModuleScope -ModuleName $Script:SHModuleName {
            $ISPSSSession = [ordered]@{
                tenant_url = 'https://somedomain.secretshub.cyberark.cloud'
                User       = $null
                TenantId   = 'SomeTenant'
                SessionId  = 'SomeSession'
                WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
        }

        $Script:response = Get-SHSecret
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secrets'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the beta Accept header' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Accept -eq 'application/x.secretshub.beta+json'
            } -Times 1 -Exactly -Scope It
        }

        It 'passes a supplied filter expression through unaltered' {
            $null = Get-SHSecret -filter 'storeName CONTAINS value'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                [uri]::UnescapeDataString($URI) -match 'filter=storeName CONTAINS value'
            } -Times 1 -Exactly -Scope It
        }

        It 'builds a filter expression from criteria, quoting a value which needs it' {
            $null = Get-SHSecret -FilterCriteria @{ Field = 'name'; Operator = 'CONTAINS'; Value = 'my value' }
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                [uri]::UnescapeDataString($URI) -match 'filter=name CONTAINS "my value"'
            } -Times 1 -Exactly -Scope It
        }

        It 'joins several criteria with AND' {
            $null = Get-SHSecret -FilterCriteria @(
                @{ Field = 'vendorType'; Operator = 'EQ'; Value = 'AWS' }
                @{ Field = 'storeName'; Operator = 'CONTAINS'; Value = 'prod' }
            )
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                [uri]::UnescapeDataString($URI) -match 'vendorType EQ AWS AND storeName CONTAINS prod'
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects an operator outside the documented query language' {
            { Get-SHSecret -FilterCriteria @{ Field = 'name'; Operator = 'HAS'; Value = 'x' } } | Should -Throw
        }

        It 'sends the projection in the query string' {
            $null = Get-SHSecret -projection EXTEND
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -match 'projection=EXTEND'
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the secrets of the response' {
            $Script:response.id | Should -Be 'secret-1'
        }

        It 'follows pagination until the reported total is collected' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
                [pscustomobject]@{ 'secrets' = @([pscustomobject]@{ id = 'secret-2' }); 'count' = 1; 'totalCount' = 2 }
            } -ParameterFilter { $URI -match 'offset=' }

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
                [pscustomobject]@{ 'secrets' = @([pscustomobject]@{ id = 'secret-1' }); 'count' = 1; 'totalCount' = 2 }
            } -ParameterFilter { $URI -notmatch 'offset=' }

            (Get-SHSecret | Measure-Object).Count | Should -Be 2
        }
    }

}
