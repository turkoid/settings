function Get-VirtualEnvironment {
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]
        $ShowHelp = $false
    )
    if ($ShowHelp) {
        Write-Output 'Pass a name to activate one of the following virtualenvs:'
        Write-Output '=============================================================================='
    }
    Get-ChildItem 'C:\home\dev\python\.virtualenvs' | Where-Object { $_.PSIsContainer } | Where-Object { Test-Path (Join-Path $_.FullName 'pyvenv.cfg') } | ForEach-Object { $_.Name }
}

class VirtualEnvironments : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [string[]] (Get-VirtualEnvironment)
    }
}

function Set-VirtualEnvironment {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateSet([VirtualEnvironments])]
        [string]$EnvName
    )

    $env:VIRTUAL_ENV_DISABLE_PROMPT = 1
    $activate = Join-Path "$env:workon_home" "$EnvName" 'scripts\activate.ps1'
    & $activate
}

function Enter-VirtualEnvironment {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [ValidateSet([VirtualEnvironments])]
        [string]$EnvName
    )

    if ($EnvName) {
        Set-VirtualEnvironment $EnvName
        Set-WorkingDirectory -IgnoreMissingProjectFile
    }
    else {
        Get-VirtualEnvironment -ShowHelp
    }
}

function Exit-VirtualEnvironment {
    $env:VIRTUAL_ENV_DISABLE_PROMPT = 0
    deactivate
}

function Set-WorkingDirectory {
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]
        $IgnoreMissingProjectFile
    )
    if (!(Test-Path env:virtual_env)) {
        Write-SimpleError 'A virtualenv must be activated'
        return
    }
    $venv_project_file = Join-Path "$env:virtual_env" '.project'
    if (!(Test-Path "$venv_project_file")) {
        if (!$IgnoreMissingProjectFile) {
            Write-SimpleError 'No .project file found for current virtualenv'
        }
        return
    }
    Set-Location -Path (Get-Content "$venv_project_file")
}

function Set-ProjectDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]
        $ProjectDir = '.'
    )

    setprojectdir.bat "$ProjectDir"
}

function Remove-VirtualEnvironment {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateSet([VirtualEnvironments])]
        [string]
        $EnvName
    )
    rmvirtualenv.bat $EnvName
}

Set-Alias venvs 'Get-VirtualEnvironment'
Set-Alias workon 'Enter-VirtualEnvironment'
Set-Alias workoff 'Exit-VirtualEnvironment'
Set-Alias cdproject 'Set-WorkingDirectory'
Set-Alias setvirtualenvproject 'Set-ProjectDirectory'
Set-Alias setvenv 'Set-VirtualEnvironment'
Set-Alias mkvirtualenv 'mkvirtualenv.bat'
Set-Alias mkvenv 'mkvirtualenv.bat'
Set-Alias rmvirtualenv 'Remove-VirtualEnvironment'
Set-Alias rmvenv 'Remove-VirtualEnvironment'

Export-ModuleMember -Alias * -Function *