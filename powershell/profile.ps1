Import-Module $env:dev_home\git\settings\powershell\bash-emulation -Force
Import-Module $env:dev_home\git\settings\powershell\virtualenvwrapper -Force
Import-Module posh-git
Import-Module oh-my-posh

function Set-CustomPoshPrompt() {
  [CmdletBinding()]
  param (
    [Parameter(Position = 0)]
    [ValidateSet('turkoid', 'turkoid_plus', 'turkoid_lite')]
    [string]
    $Name = 'turkoid'
  )
  Set-PoshPrompt -Theme (Join-Path $env:dev_home "git\settings\oh-my-posh\$Name.omp.json")
}

Set-CustomPoshPrompt
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

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

function Start-ReloadProfile {
  . $env:dev_home\git\settings\powershell\profile.ps1
}

Set-Alias np 'notepad++.exe'
Set-Alias guid 'New-Guid'
Set-Alias omp 'Set-CustomPoshPrompt'
Set-Alias rl 'Start-ReloadProfile'
Set-Alias connect_to 'Start-SshSession'

