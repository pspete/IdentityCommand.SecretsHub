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

Describe 'Get-SHConfiguration' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{ secretsSource = [pscustomobject]@{ pamType = 'PAM_SELF_HOSTED' } }
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

        $Script:response = Get-SHConfiguration
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/configuration'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }
    }
    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the configuration' {
            $Script:response.secretsSource.pamType | Should -Be 'PAM_SELF_HOSTED'
        }
    }

}
