# Module - PowerShell Basics
# URL: 

# USE ALT+Z to toggle Word Wrap for better text viewing in VS Code!!!

# M3-01
# Demo: Finding Your Way in PowerShell
# Run in Windows PowerShell console
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

# M3-02
# Demo: Gathering Computer Information
# Run in Windows PowerShell console
    Get-command *counter*
    Help Get-Counter                                               
    Get-Counter                                                                                                                                                                              
    get-counter -ListSet *memory* 
    get-counter -ListSet Memory 
    
    #View Path by Expanding
    get-counter -ListSet Memory | Select -expand Counter

    #error by design
    get-counter -Counter "\Memory\Pages /sec","\Memory\% Committed Bytes In Use" | FT
    get-counter -Counter "\Memory\Pages/Sec","\Memory\% Committed Bytes In Use" | FT

# M3-03
# Demo: Using WMI and CIM Information
# Run in Windows PowerShell
    Get-WmiObject -List *
    Get-CimClass -ClassName *
    Get-CimClass -ClassName *memory*
    Get-WmiObject -class Win32_PhysicalMemory
    Get-CimInstance -ClassName Win32_PhysicalMemory
    Get-CimInstance -ClassName Win32_PhysicalMemory | Select Tag,Capacity

# M3-04
# Demo: Working with Network Information 
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
    #In the lab environment, the directory listing will have a different set of files and directories than the video demo

# Demo: Reviewing Event Log Information
# Run in Windows PowerShell console
#Last, I want to see the last time the system had a reboot. The easiest way to see this is by finding the 1074 System event in Event Viewer. This event message signifies that the system has restarted. 
    get-command get-*Event*
    help get-eventlog -Examples
    get-eventlog -LogName System | gm

    # Enter each command on a single line
    # last two commands will be enter at the '>>' prompt
    Get-EventLog -log system -newest 1000 |
    >>where-object {$_.eventid -eq '1074'} |
    >>format-table machinename, username, timegenerated -autosize


#M3-04
# Demo: Using Get-ComputerInfo
# Run in WindowsPowerShell
    help Get-ComputerInfo
    help Get-ComputerInfo -Examples
    Get-ComputerInfo | more
    Get-ComputerInfo -Property *memory*


#m3-06-lab
# Demo: Working with Files and Directories
# Run in Windows PowerShell
# Note: Files and directories in lab environment will be different than the video

# File System CREATE FILES FROM HERE
# So let's say you are looking for files a user stored on a network drive, yet they don't know where or what they are named; just the type of file. That's not a problem with powerShell.
    Help get-childitem
    Get-ChildItem -Path c:\windows\web -Recurse
    Get-ChildItem -Path c:\windows\web -Recurse | gm
    Get-ChildItem -Path c:\windows\web -Recurse | where Extension -EQ '.PNG'
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

