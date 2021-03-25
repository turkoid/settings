function Get-VirtualEnvironment {
  echo "Pass a name to activate one of the following virtualenvs:"
  echo "=============================================================================="
  gci C:\home\dev\python\.virtualenvs | ? { $_.psiscontainer } | ? { test-path (join-path $_.fullname "pyvenv.cfg") } | foreach { $_.name }
}

function Set-VirtualEnvironment([switch]$ChangeDir, $EnvName) {
  $env:VIRTUAL_ENV_DISABLE_PROMPT = 1
  $activate = Join-Path $env:workon_home "$EnvName" "scripts\activate.ps1"
  if (!(Test-Path "$activate")) {
    Write-SimpleError "$activate does not exist"
    return
  }
  & $activate
  if ($ChangeDir) {
    cdproject
  }
}

function cdproject {
  if (!(Test-Path "$env:virtual_env")) {
    Write-SimpleError "A virtualenv must be activated"
    return
  }
  $venv_project_file = Join-Path $env:virtual_env ".project"
  if (!(Test-Path "$venv_project_file")) {
    Write-SimpleError "No project directory found for current virtualenv"
    return
  }
  cd (gc "$venv_project_file")
}

function workon {
  if ("$args") {
    Set-VirtualEnvironment -c @args
  }
  else {
    Get-VirtualEnvironment
  }
}

function workoff {
  $env:VIRTUAL_ENV_DISABLE_PROMPT = 0
  deactivate
}

function setvirtualenvproject {
  if (!"$args") {
    $args = "."
  }
  setprojectdir "$args"
}