### Use the below line to list all apps to determine how the app is named in the registry.

### Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Select-Object DisplayName
param ($appname)


 

$apps = (Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall |

    Get-ItemProperty |

        Where-Object {($_.DisplayName -match "$appname")})

 

foreach ($app in $apps) {

 

if (!$app) { Write-Host "No additional apps found."}

 

            if ($app) {

            Write-Host "Vulnerable Apps Found:"

            $name = $app.displayname

            Write-Host "$name Detected"

            $uninstall = $app.UninstallString

            Write-Host "Attempting install running $uninstall /q /n /norestart"

            $uninstallcmd = $uninstall + " /qn /norestart"

 

 

            $guid = $uninstall -replace "MsiExec.exe /X",""

            Start-Process -FilePath "$env:systemroot\system32\msiexec.exe" -ArgumentList "/x$guid /qn /norestart /l*v appappremoval.log" -Wait

            Write-Host "Verifying uninstall..."

            $success = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall |

                Get-ItemProperty |

                    Where-Object {($_.DisplayName -match "$name")}

            if ($success) {Write-Host "Uninstall of $name Successful"}

                else {Write-Host "Uninstall of $name Failed."}

                      }

 }
