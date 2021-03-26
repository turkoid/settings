function Write-SimpleError($message) {
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
}

function Start-SshSession {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateScript( { Test-Path env:ssh_$_ })]
        [string]
        $ServerAlias
    )
    ssh ([System.Environment]::GetEnvironmentVariable("ssh_$ServerAlias"))
}

Set-Alias np 'notepad++.exe'
Set-Alias guid 'New-Guid'
Set-Alias connect_to 'Start-SshSession'

Export-ModuleMember -Alias * -Function *