#The completer helper functions live in IdentityCommand's Private folder, which the psm1 loads
#into this module's scope.

#region Registration

Register-ArgumentCompleter -ParameterName 'storeId' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-SHSecretStore' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName @(
    'Get-SHSecretStore'
    'Get-SHSecretsFilter'
    'New-SHSecretsFilter'
    'Remove-SHSecretStore'
    'Remove-SHSecretsFilter'
    'Set-SHSecretStore'
    'Set-SHSecretStoreState'
    'Test-SHSecretStoreConnection'
)

Register-ArgumentCompleter -ParameterName 'secretStoresIds' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-SHSecretStore' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName 'Start-SHScan'

Register-ArgumentCompleter -ParameterName 'secretStoreIds' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-SHSecretStore' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName 'Set-SHSecretStoreState'

Register-ArgumentCompleter -ParameterName 'sourceId' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-SHSecretStore' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName 'New-SHSyncPolicy'

Register-ArgumentCompleter -ParameterName 'targetId' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-SHSecretStore' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName 'New-SHSyncPolicy'

Register-ArgumentCompleter -ParameterName 'policyId' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-SHSyncPolicy' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName @(
    'Get-SHSyncPolicy'
    'Remove-SHSyncPolicy'
    'Set-SHSyncPolicyState'
)

#endregion Registration
