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

Describe 'Set-SHSecretStoreState' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{ results = @([pscustomobject]@{ secretStoreId = 'store-1'; result = 'SUCCESS' }) }
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

        $Script:response = Set-SHSecretStoreState -storeId 'store-1' -action disable
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secret-stores/store-1/state'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'PUT'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the action in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).action -eq 'disable'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends a bulk request to the states endpoint' {
            $null = Set-SHSecretStoreState -secretStoreIds 'store-1', 'store-2' -action enable
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secret-stores/states'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the store ids in the bulk request body' {
            $null = Set-SHSecretStoreState -secretStoreIds 'store-1', 'store-2' -action enable
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).secretStoreIds.Count -eq 2
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects an unsupported action' {
            { Set-SHSecretStoreState -storeId 'store-1' -action something } | Should -Throw
        }

        It 'does not send a request when WhatIf is specified' {
            $null = Set-SHSecretStoreState -storeId 'store-8' -action enable -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -match 'store-8'
            } -Times 0 -Exactly -Scope It
        }
    }
    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the per store results' {
            $Script:response.results.result | Should -Be 'SUCCESS'
        }
    }

}
