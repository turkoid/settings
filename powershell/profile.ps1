Import-Module $env:dev_home\git\settings\powershell\common
Import-Module $env:dev_home\git\settings\powershell\cmd-emulation
Import-Module $env:dev_home\git\settings\powershell\bash-emulation
Import-Module $env:dev_home\git\settings\powershell\virtualenvwrapper
Import-Module $env:dev_home\git\settings\powershell\omp

Set-CustomPoshPrompt
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

function rl {
    . $profile
}