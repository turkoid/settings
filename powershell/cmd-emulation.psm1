function mklink {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    if ($Args.Count -lt 2) {
        Write-Host "Usage: mklink [[/D] | [/H] | [/J]] <Link> <Target>"
        Write-Host "   /D    Creates a directory symbolic link"
        Write-Host "   /H    Creates a hard link instead of a symbolic link"
        Write-Host "   /J    Creates a directory junction"
        return
    }

    # Extract Link and Target (last two args)
    $Link   = $Args[-2]
    $Target = $Args[-1]

    if ($Args.Count -gt 3) {
        throw "Multiple switches are not supported. Use only one of /D, /H, or /J."
    }

    # Default = file symbolic link
    $type = 'SymbolicLink'

    if ($Args.Count -eq 3) {
        switch ($Args[0].ToUpper()) {
            '/D' { $type = 'SymbolicLink' } # directory symlink
            '/H' { $type = 'HardLink' }     # hard link (file only)
            '/J' { $type = 'Junction' }     # directory junction
            default { throw "Invalid option: $($Args[0])" }
        }
    }

    try {
        New-Item -ItemType $type -Path $Link -Target $Target -Force | Out-Null
        Write-Host "Created ${type}: $Link -> $Target"
    }
    catch {
        Write-SimpleError "Failed to create link: $_"
    }
}
