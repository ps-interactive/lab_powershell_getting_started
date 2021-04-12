# M3-01
    get-command -Name *Fire*
    get-command -Name get-*Fire*
    get-command -Name get-NetFire*
    help Get-NetFirewallRule
    Get-NetFirewallRule | gm
    Get-NetFirewallRule
    Get-NetFirewallRule -Name *Remote* 
    Get-NetFirewallRule -Name *RemoteDesktop* 
    Get-NetFirewallRule -Name *RemoteDesktop* | FT
    Get-NetFirewallRule -Name *RemoteDesktop* | Set-NetFirewallRule -Enabled 'True' -Whatif
    Get-NetFirewallRule -Name *RemoteDesktop* | FT

# M3-01b
    Get-command *counter*
    Help Get-Counter                                               
    Get-Counter                                                                                                                                                                              
    get-counter -ListSet *memory* 
    get-counter -ListSet Memory 
    #View Path by Expanding
    ::
    get-counter -ListSet Memory | Select -expand Counter
    ::
    #error by design
    get-counter -Counter "\Memory\Pages /sec","\Memory\% Committed Bytes In Use" | FT
    get-counter -Counter "\Memory\Pages/Sec","\Memory\% Committed Bytes In Use" | FT

# M3-02
    Get-WmiObject -List *
    Get-CimClass -ClassName *
    Get-CimClass -ClassName *memory*
    Get-WmiObject -class Win32_PhysicalMemory
    Get-CimInstance -ClassName Win32_PhysicalMemory
    Get-CimInstance -ClassName Win32_PhysicalMemory | Select Tag,Capacity
# M3-03
#Last, I want to see the last time the system had a reboot. The easiest way to see this is by finding the 1074 System event in Event Viewer. This event message signifies that the system has restarted. 
    get-command get-*Event*
    help get-eventlog -Examples
    get-eventlog -LogName System | gm
    ::
    Get-EventLog -log system �newest 1000 |
    where-object {$_.eventid �eq '1074'} |
    format-table machinename, username, timegenerated �autosize
    ::
    :: 
    Get-EventLog -log system �newest 1000 |
    where-object eventid �eq '1074' |
    format-table machinename, username, timegenerated �autosize
    ::
#M3-04
    help Get-ComputerInfo
    help Get-ComputerInfo -Examples
    Get-ComputerInfo | more
    Get-ComputerInfo -Property *memory*

# M3-05 
ipconfig                                                                                 
ipconfig /all
ipconfig | gm                                                                          
Get-Command get-NetIP*                                                                                
Get-NetIPAddress                                                                         
Get-NetIPConfiguration

GCM get-*DNS* 
GCM get-DNSClient*                                                                  
Get-DnsClient                                                                                                                                              
Get-DnsClientCache                                                                                                                                              
Get-DnsClientServerAddress                                                               

#Map a Network Drive > Use SMB or simple message block so we need to search for SMB related commands
  
    Get-Command *SMB*
    Get-Command *SmbMapping                                                                        
    Help New-SmbMapping -examples
    New-SMBmapping -localPath w: -remotepath \\DC01\Share
    Get-smbmapping
    cd w:\
    dir
    cd c:\scripts\m3

    ping 4.2.2.1                                                                             
    tracert 4.2.2.1                                                                          
    Test-NetConnection -TraceRoute 4.2.2.1                                                   
    Test-NetConnection -CommonTCPPort 80 -ComputerName 4.2.2.1                               
    Test-NetConnection -CommonTCPPort HTTP -ComputerName 4.2.2.1                             
    Test-NetConnection -CommonTCPPort HTTP -ComputerName Pluralsight.com
#m3-06-lab
# File System CREATE FILES FROM HERE
# So let's say you are looking for files a user stored on a network drive, yet they don't know where or what they are named; just the type of file. That's not a problem with powerShell.
    Help get-childitem
    Get-ChildItem -Path c:\windows\web -Recurse
    Get-ChildItem -Path c:\windows\web -Recurse | gm
    Get-ChildItem -Path c:\windows\web -Recurse | where Extension -EQ '.jpg'
    Get-ChildItem -Path c:\windows\web -Recurse | where Extension -EQ '.PNG' | ft Directory,Name,LastWriteTime
#Now lets say I want to move files from 
    Gcm *copy*
    help Copy-Item -Examples
    copy-item c:\windows\web -Destination c:\CopiedFolder -Recurse -Verbose
    dir c:\CopiedFolder -recurse
    move-item c:\CopiedFolder -Destination c:\MovedFolder -verbose
    dir c:\MovedFolder -Recurse
    Rename-Item c:\MovedFolder -NewName c:\RenamedFolder
    dir c:\

# cd C:\Windows\Web
