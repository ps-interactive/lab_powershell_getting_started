# This script will add your client computer into the company.co domain in the Lab environment.
# Due to technical reasons, the client will auto-logon with the local administrator account upon reboot.
# When required, domain credentials will be provided with commands to perform certain actions

# Rename Computer and Join computer to domain using password from c:/companypw.txt
$domain = "company.co"
$compname = "client02"
$pwd = get-content c:/users/administrator/desktop/lab_files/companypw.txt
$secpwd = ConvertTo-SecureString $pwd -AsPlainText -Force
$password = ConvertTo-SecureString "MyPlainTextPassword" -AsPlainText -Force
$admin = "company\administrator"
$Cred = New-Object System.Management.Automation.PSCredential ($admin, $secpwd)
Write-host "Renaming computer to $compname"
Rename-Computer -NewName $compname 
Write-host "Adding computer to $domain domain"
Add-Computer -domain $domain -server DC01 -credential $Cred 
Write-host "Reboot system in 10s"
pause 10
Restart-Computer -Force