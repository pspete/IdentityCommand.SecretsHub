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

Describe 'Publish-SHSecret' {

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

        $Script:response = Publish-SHSecret -sourceSecretStoreType AWS_ASM -targetSecretStoreType PAM_PCLOUD -secretId 'secret-1' -secretValueType PLAINTEXT -safeName 'my-safe' -pamAccount @{ name = 'accountName'; platformId = 'WinServerLocal' }
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.secretshub.cyberark.cloud/api/secrets-onboarding/AWS_ASM/PAM_PCLOUD'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the beta Accept header' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                $Accept -eq 'application/x.secretshub.beta+json'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the secret id in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).secretId -eq 'secret-1'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the pam account in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).pamAccount.platformId -eq 'WinServerLocal'
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send the store types in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:SHModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).PSObject.Properties.Name -notcontains 'sourceSecretStoreType'
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects an unsupported target store type' {
            { Publish-SHSecret -sourceSecretStoreType AWS_ASM -targetSecretStoreType AWS_ASM -secretId 'x' -secretValueType PLAINTEXT -safeName 's' -pamAccount @{ } } |
                Should -Throw
        }
    }

}
