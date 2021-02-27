# PowerShell to Disable UAC on Windows 10
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system' -Name 'EnableLUA' -value 0
