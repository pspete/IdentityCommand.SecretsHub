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

Describe 'Get-SHSyncPolicy' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{
                'policies' = @([pscustomobject]@{ id = 'policy-1'; name = 'SomePolicy' })
                'count'    = 1
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

        $Script:response = Get-SHSyncPolicy
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/policies'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'requests a single policy by id' {
            $null = Get-SHSyncPolicy -policyId 'policy-1'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/policies/policy-1'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the projection when requesting a single policy' {
            $null = Get-SHSyncPolicy -policyId 'policy-1' -projection EXTEND
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($URI -match 'projection=EXTEND') -and ($URI -match 'policy-1')
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send the policy id as a query parameter' {
            $null = Get-SHSyncPolicy -policyId 'policy-1' -projection EXTEND
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($URI -match 'policy-1') -and ($URI -notmatch 'policyId=')
            } -Times 1 -Exactly -Scope It
        }

        It 'sends a filter expression in the query string' {
            $null = Get-SHSyncPolicy -filter 'filter.safeName EQ MySafeName'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                [uri]::UnescapeDataString($URI) -match 'filter=filter.safeName EQ MySafeName'
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the policies of the response' {
            $Script:response.id | Should -Be 'policy-1'
        }

        It 'pages on the reported count' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
                [pscustomobject]@{ 'policies' = @([pscustomobject]@{ id = 'policy-2' }); 'count' = 2 }
            } -ParameterFilter { $URI -match 'offset=' }

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
                [pscustomobject]@{ 'policies' = @([pscustomobject]@{ id = 'policy-1' }); 'count' = 2 }
            } -ParameterFilter { $URI -notmatch 'offset=' }

            (Get-SHSyncPolicy | Measure-Object).Count | Should -Be 2
        }
    }

}
