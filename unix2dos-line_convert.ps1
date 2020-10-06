<#
# Security Bypass script has to be named "unix2dos-line_convert.bat" (matching the name of this powershell script) and has to contain following:
@echo off
powershell -ExecutionPolicy Bypass -Command "& '%~d0%~p0%~n0.ps1' '%1'"
#>
Write-Host "`t`t`t>> LF 2 CR-LF Simple Converter <<`n"

[string]$str = Write-Output $args[0]                # Input file; input from cmd bypass script
[string]$new_file = $str.split("\")[-1]             # Extract file name
[string]$out_path = "~\Documents\u2d"     # Output directory

FUNCTION Covert-LineEndings {
    Write-Host "Converting, please wait...`n"
    Get-Content $str | Out-File "$out_path\$new_file"
    Write-Host "> Converted file can be found here: $out_path\$new_file `n"
}

if ( $args -ne $null ) { 
    if ( -not ( Test-Path $out_path )) { 
        Write-Host "INFO: Folder $out_path will be created!" 
        New-Item -Path $out_path -ItemType "directory" | Out-Null
    }
    Covert-LineEndings
    pause
}
else { Write-Host "ERROR: Input file was not provided! Use Drag'n'Drop ;-)"; pause}
