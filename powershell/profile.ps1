Import-Module $PSScriptRoot\common
Import-Module $PSScriptRoot\cmd-emulation
Import-Module $PSScriptRoot\bash-emulation
Import-Module $PSScriptRoot\virtualenvwrapper
Import-Module $PSScriptRoot\omp
Import-Module git-completion

Set-CustomPoshPrompt
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

function rl {
    . $profile
}
