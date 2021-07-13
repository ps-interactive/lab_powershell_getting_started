# This script will add your client computer into the company.co domain in the Lab environment.
# Due to technical reasons, the client will auto-logon with the local administrator account upon reboot.
# When required, domain credentials will be provided with commands to perform certain actions

# Rename Computer and Join computer to domain using password from c:/companypw.txt
$domain = "company.co"
$compname = "client01"
$pwd = get-content c:/users/administrator/desktop/lab_files/companypw.txt
$secpwd = ConvertTo-SecureString $pwd -AsPlainText -Force
$admin = "company\administrator"
$Cred = New-Object System.Management.Automation.PSCredential ($admin, $secpwd)
$dc = "DC01"
Write-Host "This script will rename the computer to $compname, and add it into domain $domain"
Write-host ""
Write-host "Because the domain controller $dc is building, this process may take a few minutes to complete"
Write-host ""
Write-host "After the script completes and the computer reboots, you can begin the lab"
Write-host ""
do {
    Write-Host "Checking netlogon service on $DC"
    $netlogonsvc =(Get-CimInstance -ClassName Win32_service -Filter "Name = 'netlogon'" -ComputerName $dc -ErrorAction SilentlyContinue).state 
    sleep 15
} until ($netlogonsvc -ne 'running')
Write-host "Renaming computer to $compname"
Rename-Computer -NewName $compname 
Write-host "Adding computer to $domain domain"
Add-Computer -domain $domain -server DC01 -credential $Cred 
Restart-Computer -Force