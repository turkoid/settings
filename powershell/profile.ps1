Import-Module $env:dev_home\git\settings\powershell\bash-emulation -Force
Import-Module $env:dev_home\git\settings\powershell\virtualenvwrapper -Force
Import-Module $env:dev_home\git\settings\powershell\omp -Force
Import-Module $env:dev_home\git\settings\powershell\common -Force

Set-CustomPoshPrompt
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

function rl {
    . $profile
}