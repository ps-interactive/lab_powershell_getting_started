# This script will add your client computer into the company.co domain in the Lab environment.
# Due to technical reasons, the client will auto-logon with the local administrator account upon reboot.
# When required, domain credentials will be provided with commands to perform certain actions

#variables
$domain = "company.co"
$computername = "Client01"
$dc = "DC01"
$pwd = get-content c:/users/administrator/desktop/lab_files/companypw.txt
$secpwd = ConvertTo-SecureString $pwd -AsPlainText -Force
$admin = "company\administrator"
$Cred = New-Object System.Management.Automation.PSCredential ($admin, $secpwd)
# Message
Write-Host "This script will rename the computer to $computername, and add it into domain $domain"
Write-host ""


# Rename Computer

Write-host "Renaming computer to $computername"
Rename-Computer -NewName $computername -PassThru -Verbose 
# Join computer to domain using password from c:/companypw.txt
Write-host ""
Write-host "Because the domain controller $dc is building, this process may take a 7-10 minutes to complete"
Write-host ""
Write-host "After the script completes and the computer reboots, you can begin the lab"
Write-host ""
$i = 30
do {
    #sleep 10
    Write-Host "Checking netlogon service on $DC - Script will continue when domain controller is available"
    $netlogonsvc =(Get-CimInstance -ClassName Win32_service -Filter "Name = 'netlogon'" -ComputerName $dc -ErrorAction SilentlyContinue).state 
    
    if ($netlognsvc -ne "running") {
        write-host "Current State: Unavailable"
    } else { 
        Write-host "Current State: $netlogonsvc" 
    }
    
    Write-host ""
    Write-host ""
    # sleep 20
} until ($netlogonsvc -eq 'running')

Write-host "Adding computer to $domain domain"
Write-host ""
# add-computer -domain company.co -server $dc -credential (Get-credential -Message "Enter Administrator and password from the file c:\companypw.txt. Computer will automatically restart.") -force -verbose -restart
Add-Computer -domain $domain -credential $Cred -PassThru -Verbose
write-host ""
write-host "Rebooting Computer..."
restart-computer -Force -Timeout 5