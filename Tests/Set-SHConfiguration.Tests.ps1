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

Describe 'Set-SHConfiguration' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -MockWith {
            $null
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

        $Script:response = Set-SHConfiguration -secretValidity 400
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
                $Method -eq 'PATCH'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the secret validity nested under syncSettings' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).syncSettings.secretValidity -eq 400
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the gcp replication regions when supplied' {
            $null = Set-SHConfiguration -gcpReplicationRegion 'us-central1', 'europe-west1'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).syncSettings.gcp.secretReplication.regions.Count -eq 2
            } -Times 1 -Exactly -Scope It
        }

        It 'sends an empty region list to revert to global replication' {
            $null = Set-SHConfiguration -gcpReplicationRegion @()
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $null -ne ($Body | ConvertFrom-Json).syncSettings.gcp.secretReplication
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects a secret validity outside the supported range' {
            { Set-SHConfiguration -secretValidity 731 } | Should -Throw
        }

        It 'does not send a request when WhatIf is specified' {
            $null = Set-SHConfiguration -secretValidity 123 -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Body -match '123'
            } -Times 0 -Exactly -Scope It
        }
    }

}
