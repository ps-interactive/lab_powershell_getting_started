

#m4-01
#Demo: Requirements for Remoting on Windows PowerShell
get-service -computername Client01


#m4-02
#Variables in current console
Get-ChildItem ENV: | more

$env:Computername

Get-Variable | More

#Version of PowerShell
$PSVersionTable

#Create variable for remote computer
$ComputerName = “Client02”
$ComputerName
Write-Output "The name of the remote computer is $computername"
Write-Output 'The name of the variable for the remote computername is $computername'

#Store Credential
$credential = Get-Credential
$credential

Get-Variable -Name c*

#nter-PSSession -ComputerName $ComputerName -Credential cred

Get-Service -ComputerName $computername

#m4-03
#Using Computername parameter
Get-Service –computername $ComputerName | select Name,Status

#Using PSSession
Gcm *-PSSession
#Create a PSSession
$ComputerName = “Client02”
$credential = Get-Credential
New-PSSession -ComputerName $ComputerName -Credential $credential
Enter-PSSession -Name $ComputerName
Get-PSSession
Enter-PSSession -Id 2
Get-PSSession
Remove-PSSession -id 2
Get-PSSession

#m4-04
#Running command on Remote System
help Invoke-command
$ComputerName = "Client02"
$credential = Get-Credential

Invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $ComputerName }

invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $using:ComputerName }

$data =  invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $using:ComputerName }

$data | gm

$Data | Select Name,Status,Description

#On PowerShell Core 
# Running Remote Commands
invoke-command -ComputerName DC01 -cred (get-credential) -ScriptBlock { Get-ADUser -Identity felixb | format-list }



#m4-05

#m4-06
#Using New-Cimsession
$ComputerName = 'Client02'
$credential = Get-Credential

Help New-Cimsession

$cimsession = New-CimSession -ComputerName $ComputerName -Credential $Credential

$cimsession

Get-CimSession

Help Get-DNSClientServerAddress

Get-DNSClientServerAddress -CimSession $CimSession
