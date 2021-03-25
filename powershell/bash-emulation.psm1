function bash_grep {
  $input | out-string -stream | select-string @args
}

function bash_touch($path) {
  if (!(Test-Path "$path")) {
    Set-Content -Path "$path" -Value ($null)
  }
  else {
    (Get-Item "$path").LastWriteTime = Get-Date
  }
}

function bash_ls_alF {
  Get-ChildItem -force @args
}

function bash_ls_alF_no_system {
  Get-ChildItem -force -attributes !s @args
}

function bash_rm_rf {
  Remove-Item -Recurse -Force @args
}

Set-Alias grep "bash_grep"
Set-Alias touch "bash_touch"
Set-Alias la "bash_ls_alF"
Set-Alias ll "bash_ls_alF_no_system"
Set-Alias rmrf "bash_rm_rf"

Export-ModuleMember -Alias * -Function *