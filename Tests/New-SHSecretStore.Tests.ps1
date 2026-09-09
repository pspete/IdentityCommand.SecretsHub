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

Describe 'New-SHSecretStore' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{ id = 'store-1'; name = 'SomeStore'; type = 'AWS_ASM' }
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

        $Script:response = New-SHSecretStore -type AWS_ASM -name 'SomeStore' -data @{ accountId = '123456789012'; regionId = 'us-east-1' }
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
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the type in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).type -eq 'AWS_ASM'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the data in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).data.accountId -eq '123456789012'
            } -Times 1 -Exactly -Scope It
        }

        It 'omits the state when not supplied' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).PSObject.Properties.Name -notcontains 'state'
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects an unsupported store type' {
            { New-SHSecretStore -type SOMETHING -name 'x' -data @{ accountId = '1' } } | Should -Throw
        }

        It 'does not send a request when WhatIf is specified' {
            $null = New-SHSecretStore -type AWS_ASM -name 'NotCreated' -data @{ accountId = '1' } -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Body -match 'NotCreated'
            } -Times 0 -Exactly -Scope It
        }
    }
    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the created secret store' {
            $Script:response.id | Should -Be 'store-1'
        }
    }

}
