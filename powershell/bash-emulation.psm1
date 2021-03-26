function Find-String {
    $Input | Out-String -Stream | Select-String @args
}

function New-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    process {
        if (Test-Path "$Path") {
            (Get-Item "$Path").LastWriteTime = Get-Date
        }
        else {
            Set-Content $Path -Value ($null)
        }
    }
}

function Get-AllFiles {
    Get-ChildItem -Force @args
}

function Get-AllNonSystemFiles {
    Get-AllFiles -attributes !s @args
}

function Select-Command {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
        [string]
        $Command,

        [Parameter()]
        [switch]
        $All
    )
    process {
        $Locations = (where.exe $Command)
        if ($All -or !$Locations) {
            return $Locations
        }
        else {
            return $Locations[0]
        }
    }
}

function Invoke-RemoteItem {
    param (
        [switch]
        $rf
    )
    if ($rf) {
        Remove-Item -Force -Recurse @args
    }
    else {
        Remove-Item @args
    }
}

Set-Alias grep 'Find-String'
Set-Alias touch 'New-File'
Set-Alias la 'Get-AllFiles'
Set-Alias ll 'Get-AllNonSystemFiles'
Set-Alias rm 'Invoke-RemoteItem'
Set-Alias whereis 'Select-Command'

Export-ModuleMember -Alias * -Function *