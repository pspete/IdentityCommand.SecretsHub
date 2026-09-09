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

Describe 'New-SHSyncPolicy' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            [pscustomobject]@{ id = 'policy-1'; name = 'SomePolicy' }
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

        $Script:response = New-SHSyncPolicy -name 'SomePolicy' -sourceId 'store-source' -targetId 'store-target' -safeName 'my-safe'
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
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the source and target as nested identifiers' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                (($Body | ConvertFrom-Json).source.id -eq 'store-source') -and
                (($Body | ConvertFrom-Json).target.id -eq 'store-target')
            } -Times 1 -Exactly -Scope It
        }

        It 'defines the filter inline from a safe name' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                (($Body | ConvertFrom-Json).filter.type -eq 'PAM_SAFE') -and
                (($Body | ConvertFrom-Json).filter.data.safeName -eq 'my-safe')
            } -Times 1 -Exactly -Scope It
        }

        It 'references an existing filter by id' {
            $null = New-SHSyncPolicy -name 'Other' -sourceId 'store-source' -targetId 'store-target' -filterId 'filter-1'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).filter.id -eq 'filter-1'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends a predefined transformation when supplied' {
            $null = New-SHSyncPolicy -name 'Other' -sourceId 'store-source' -targetId 'store-target' -safeName 'my-safe' -transformation password_only_plain_text
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).transformation.predefined -eq 'password_only_plain_text'
            } -Times 1 -Exactly -Scope It
        }

        It 'omits the transformation when not supplied' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).PSObject.Properties.Name -notcontains 'transformation'
            } -Times 1 -Exactly -Scope It
        }

        It 'does not accept a safe name alongside a filter id' {
            { New-SHSyncPolicy -name 'x' -sourceId 'a' -targetId 'b' -safeName 's' -filterId 'f' } | Should -Throw
        }

        It 'does not send a request when WhatIf is specified' {
            $null = New-SHSyncPolicy -name 'NotCreated' -sourceId 'a' -targetId 'b' -safeName 's' -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Body -match 'NotCreated'
            } -Times 0 -Exactly -Scope It
        }
    }
    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the created policy' {
            $Script:response.id | Should -Be 'policy-1'
        }
    }

}
