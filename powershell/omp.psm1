$script:OhMyPoshDir = Join-Path "$PSScriptRoot" "..\oh-my-posh"

class CustomOhMyPoshThemes : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        $ValidProfiles = [System.Collections.ArrayList]::new()
        foreach ($Path in (Get-ChildItem (Join-Path "$script:OhMyPoshDir" "*.omp.json"))) {
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
    if ($Name -like 'tk*' -and !(Test-Path (Join-Path "$script:OhMyPoshDir" "$Name.omp.json"))) {
        $Name = 'turkoid' + $Name.Substring(2)
    }
    oh-my-posh init pwsh --config (Join-Path "$script:OhMyPoshDir" "$Name.omp.json") | Invoke-Expression
}

Set-Alias omp 'Set-CustomPoshPrompt'

Export-ModuleMember -Alias * -Function *
