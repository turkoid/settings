function Find-String {
  $Input | Out-String -Stream | Select-String $args
}

function New-File {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $Path
  )

  if (Test-Path "$Path") {
    (Get-Item "$Path").LastWriteTime = Get-Date
  }
  else {
    Set-Content $Path -Value ($null)
  }
}

function Get-AllFiles {
  Get-ChildItem -Force @args
}

function Get-AllNonSystemFiles {
  Get-AllFiles -attributes !s @args
}

function bash_rm_rf {
  Remove-Item -Recurse -Force @args
}

function Select-Command {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]
    $Command
  )
  where.exe $Command
}

function Remove-Stuff {
  [CmdletBinding()]
  param (
    [Parameter()]
    [switch]
    $rf,

    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $Path,

    [Parameter(Position = 1, ValueFromRemainingArguments)]
    $Remaining
  )

  if ($rf) {
    Remove-Item -Path "$Path" -Force -Recurse @Remaining
  }
  else {
    Remove-Item -Path "$Path" @Remaining
  }
}

Set-Alias grep 'Find-String'
Set-Alias touch 'New-File'
Set-Alias la 'Get-AllFiles'
Set-Alias ll 'Get-AllNonSystemFiles'
Set-Alias rm 'Remove-Stuff'

Export-ModuleMember -Alias * -Function *