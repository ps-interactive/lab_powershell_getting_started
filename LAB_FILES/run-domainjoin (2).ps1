# This script will add your client computer into the company.co domain in the Lab environment.
# Due to technical reasons, the client will auto-logon with the local administrator account upon reboot.
# When required, domain credentials will be provided with commands to perform certain actions

#variables
$computername = "Client01"
$dc = "DC01"

# Message
Write-Host "This script will rename the computer to $computername, and add it into domain $domain"
Write-host ""
Write-host "Because the domain controller $dc is building, this process may take a few minutes to complete"
Write-host ""
Write-host "After the script completes and the computer reboots, you can begin the lab"
Write-host ""

# Rename Computer

Write-host "Renaming computer to "
Rename-Computer -NewName $computername 
# Join computer to domain using password from c:/companypw.txt
do {
    Write-Host "Checking netlogon service on $DC"
    $netlogonsvc =(Get-CimInstance -ClassName Win32_service -Filter "Name = 'netlogon'" -ComputerName $dc -ErrorAction SilentlyContinue).state 
    Write-host "Current State: $netlogonsvc" #Remark out when production
    sleep 5
} until ($netlogonsvc -eq 'running')
add-computer -domain company.co -server $dc -credential (Get-credential -Message "Enter Administrator and password from the file c:\companypw.txt. Computer will automatically restart.") -force -verbose -restart | out-file "c:\logging.txt" -append
