Import-Module posh-git
Import-Module oh-my-posh

function turkoid_omp($theme) {
  Set-PoshPrompt -Theme (Join-Path $env:dev_home "git\settings\oh-my-posh\$theme.omp.json")
}

function tk_omp() {
  turkoid_omp "turkoid"
}

function tk_plus_omp() {
  turkoid_omp "turkoid_plus"
}

function tk_lite_omp() {
  turkoid_omp "turkoid_lite"
}

tk_omp

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

function Write-SimpleError($message) {
  [Console]::ForegroundColor = 'red'
  [Console]::Error.WriteLine($message)
  [Console]::ResetColor()
}

function ssh_env($var) {
  ssh ([System.Environment]::GetEnvironmentVariable($var))
}

Set-Alias np "notepad++.exe"
Set-Alias guid "New-Guid"