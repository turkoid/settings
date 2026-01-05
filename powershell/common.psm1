function Write-SimpleError($message) {
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
}

function Get-SshServer {
    Get-Item env:ssh_* | Sort-Object Name | ForEach-Object { $_.Name.Substring(4) }
}

class SshServers : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [string[]] (Get-SshServer)
    }
}

function Start-SshSession {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateSet([SshServers])]
        [string]
        $ServerAlias
    )
    ssh (Get-Item env:"ssh_$ServerAlias").Value
}

Set-Alias np 'notepad++.exe'
Set-Alias guid 'New-Guid'
Set-Alias connect_to 'Start-SshSession'
Set-Alias hack 'Start-SshSession'

Export-ModuleMember -Alias * -Function *
