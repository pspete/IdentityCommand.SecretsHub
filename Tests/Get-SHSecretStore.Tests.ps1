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

Describe 'Get-SHSecretStore' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{
                'secretStores' = @([pscustomobject]@{ id = 'store-1'; name = 'SomeStore'; type = 'AWS_ASM' })
                'count'        = 1
                'totalCount'   = 1
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

        $Script:response = Get-SHSecretStore
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secret-stores'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'requests a single secret store by id' {
            $null = Get-SHSecretStore -storeId 'store-1'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secret-stores/store-1'
            } -Times 1 -Exactly -Scope It
        }

        It 'passes a supplied filter expression through unaltered' {
            $null = Get-SHSecretStore -filter 'type EQ AWS_ASM'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                [uri]::UnescapeDataString($URI) -match 'filter=type EQ AWS_ASM'
            } -Times 1 -Exactly -Scope It
        }

        It 'builds a filter expression from criteria' {
            $null = Get-SHSecretStore -FilterCriteria @(
                @{ Field = 'type'; Operator = 'EQ'; Value = 'AWS_ASM' }
                @{ Field = 'state'; Operator = 'EQ'; Value = 'ENABLED' }
            )
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                [uri]::UnescapeDataString($URI) -match 'filter=type EQ AWS_ASM AND state EQ ENABLED'
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send the filter criteria as a query parameter of their own' {
            $null = Get-SHSecretStore -FilterCriteria @{ Field = 'type'; Operator = 'EQ'; Value = 'AWS_ASM' }
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($URI -match 'filter=') -and ($URI -notmatch 'FilterCriteria')
            } -Times 1 -Exactly -Scope It
        }

        It 'sends paging and search parameters in the query string' {
            $null = Get-SHSecretStore -limit 50 -offset 10 -search 'my-store' -sort 'name DESC'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($URI -match 'limit=50') -and ($URI -match 'offset=10') -and ($URI -match 'search=my-store')
            } -Times 1 -Exactly -Scope It
        }

        It 'does not accept a filter expression alongside filter criteria' {
            { Get-SHSecretStore -filter 'type EQ AWS_ASM' -FilterCriteria @{ Field = 'a'; Operator = 'EQ'; Value = 'b' } } |
                Should -Throw
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the secret stores of the response' {
            $Script:response.id | Should -Be 'store-1'
        }

        It 'follows pagination until the reported total is collected' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
                [pscustomobject]@{ 'secretStores' = @([pscustomobject]@{ id = 'store-2' }); 'count' = 1; 'totalCount' = 2 }
            } -ParameterFilter { $URI -match 'offset=' }

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
                [pscustomobject]@{ 'secretStores' = @([pscustomobject]@{ id = 'store-1' }); 'count' = 1; 'totalCount' = 2 }
            } -ParameterFilter { $URI -notmatch 'offset=' }

            (Get-SHSecretStore | Measure-Object).Count | Should -Be 2
        }
    }

}
