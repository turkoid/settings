Import-Module posh-git
# Import-Module oh-my-posh

class CustomOhMyPoshThemes : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        $ValidProfiles = [System.Collections.ArrayList]::new()
        foreach ($Path in (Get-ChildItem (Join-Path "$env:dev_home" 'git\settings\oh-my-posh\*.omp.json'))) {
            $Name = $Path.Name.Substring(0, $Path.Name.Length - 9)
            $ValidProfiles.Add($Name)
            if ($Name -like 'turkoid*') {
                $Alias = 'tk' + $Name.Substring(7)
                if (!$ValidProfiles.Contains($Alias)) {
                    $ValidProfiles.Add($Alias)
                }
            }
        }
        return $ValidProfiles.ToArray()
    }
}

function Set-CustomPoshPrompt() {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [ValidateSet([CustomOhMyPoshThemes])]
        [string]
        $Name = 'turkoid'
    )
    if ($Name -like 'tk*' -and !(Test-Path (Join-Path $env:dev_home "git\settings\oh-my-posh\$Name.omp.json"))) {
        $Name = 'turkoid' + $Name.Substring(2)
    }
    oh-my-posh --init --shell pwsh --config (Join-Path $env:dev_home "git\settings\oh-my-posh\$Name.omp.json") | Invoke-Expression
    # Set-PoshPrompt -Theme (Join-Path $env:dev_home "git\settings\oh-my-posh\$Name.omp.json")
}

Set-Alias omp 'Set-CustomPoshPrompt'

Export-ModuleMember -Alias * -Function *