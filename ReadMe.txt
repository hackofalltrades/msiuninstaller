### Usage autouninstall.ps1 -appname "Apache Tomcat"
### Use the below line to list all apps to determine how the app is named in the registry.
### Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Select-Object DisplayName