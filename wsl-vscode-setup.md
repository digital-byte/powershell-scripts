#TODO: turn into a script
#Requires -RunAsAdministrator

# enable WSL and VM, reboot required!
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

# Install Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# default version
wsl --set-default-version 2

# Kernel update
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

# Install wsl remote for vs code
Remote - WSL in Visual Studio Code

# Setup default shell
# Ctrl + Shift + P
# Search Terminal: Select Default Shell
# Select WSL

