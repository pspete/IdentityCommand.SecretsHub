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

Describe 'New-SHSecretsFilter' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{ id = 'filter-1'; type = 'PAM_SAFE' }
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

        $Script:response = New-SHSecretsFilter -storeId 'store-1' -safeName 'my-safe'
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secret-stores/store-1/filters'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the safe name and PAM_SAFE type in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                (($Body | ConvertFrom-Json).type -eq 'PAM_SAFE') -and
                (($Body | ConvertFrom-Json).data.safeName -eq 'my-safe')
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send a request when WhatIf is specified' {
            $null = New-SHSecretsFilter -storeId 'store-1' -safeName 'not-created' -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Body -match 'not-created'
            } -Times 0 -Exactly -Scope It
        }
    }
    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the created filter' {
            $Script:response.id | Should -Be 'filter-1'
        }
    }

}
