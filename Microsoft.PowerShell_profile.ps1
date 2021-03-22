Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None

function bash_grep {
  $input | out-string -stream | select-string $args
}

function bash_touch {
  if ((Test-Path -Path ($args[0])) -eq $false) {
    Set-Content -Path ($args[0]) -Value ($null)
  }
  else {
    (Get-Item ($args[0])).LastWriteTime = Get-Date
  }
}

function bash_ls_alF {
  Get-ChildItem -force $args
}

function bash_ls_alF_no_system {
  Get-ChildItem -force -attributes !s $args
}

function bash_rm_rf {
  Remove-Item -Recurse -Force $args
}

function ssh_env {
  param (
    $env_var
  )

  ssh ([System.Environment]::GetEnvironmentVariable("$env_var"))
}

Set-Alias np "notepad++.exe"
Set-Alias guid "New-Guid"
Set-Alias grep "bash_grep"
Set-Alias touch "bash_touch"
Set-Alias la "bash_ls_alF"
Set-Alias ll "bash_ls_alF_no_system"
Set-Alias rmrf "bash_rm_rf"
