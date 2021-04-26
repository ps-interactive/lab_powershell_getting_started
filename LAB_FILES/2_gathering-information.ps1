# Lab 1 - PowerShell: Getting Started
# Module - Gathering Information with PowerShell

##### Notes and helpful Items - PLEASE READ #####
# USE ALT+Z to toggle Word Wrap on the remarks for easier reading in VS Code.

# Unless specified, Windows PowerShell and PowerShell 7 consoles need to be launced as Administrator using 'run as administrator' option by right-clicking icon.

# The lab environment has a single client (Client01) and a domain controller (DC01).

# The lab environment has no internet access so actions requiring the Internet will not be performed.

# All remote actions performed with Client02 as a target the video course demos will be performed with DC01 instead.

# The commands below are not intended to be run in VS Code. They are intended to be type (preferred) or copy/pasted into the PowerShell console used in each demo.

# Read all of the remarks (hash-tagged green lines) as non-command steps and information is included throughout this script.

# Some demo commands have been modified to work within the lab environment. They will perform the same general tasks, but may have different references such as file directories. Also, any tasks requiring internet access will be skipped.

# Use of cls in code is to clear-host or clear the screen during demos. This can be skipped during your labs if desired.

# Demo: Finding Your Way in PowerShell
    # Run these commands in Windows PowerShell console as Administrator
    
    # Using get-command to find cmdlet for Windows Firewall
        get-command -Name *Fire*
        get-command -Name get-*Fire*
        get-command -Name get-NetFire*
        help Get-NetFirewallRule
    
    # Using get-member (alias gm) expose objects
        Get-NetFirewallRule | gm
        Get-NetFirewallRule
    
    # Retrieve Firewall rules for Remote Desktop
        Get-NetFirewallRule -Name *Remote* 
        Get-NetFirewallRule -Name *RemoteDesktop* 
        Get-NetFirewallRule -Name *RemoteDesktop* | FT
    
    # Use pipeline to set Firewall rule
        Get-NetFirewallRule -Name *RemoteDesktop* | Set-NetFirewallRule -Enabled 'True' -Whatif
        Get-NetFirewallRule -Name *RemoteDesktop* | FT

# Demo: Gathering Computer Information
    # Run these commands in Windows PowerShell console as Administrator
    
    # Gathering counter information
        Get-command *counter*
        Help Get-Counter                                               
        Get-Counter                                                                                                                                                                              
        get-counter -ListSet *memory* 
        get-counter -ListSet Memory 
    
    #View Path by Expanding
        get-counter -ListSet Memory | Select -expand Counter

    #  error by design
    #  First command fails because counter name is incorrec for Memory Pages per Second
        #Note the space before /sec
        get-counter -Counter "\Memory\Pages /sec","\Memory\% Committed Bytes In Use" | FT
        get-counter -Counter "\Memory\Pages/Sec","\Memory\% Committed Bytes In Use" | FT


# Demo: Using WMI and CIM Information
    # Run these commands in Windows PowerShell console as Administrator
    
    # Using WMI and CIM to find physical memory information
    # Remember: -class and -classname parameter values are the same for most WMI/CIM calls
        Get-WmiObject -List *
        Get-CimClass -ClassName *
        Get-CimClass -ClassName *memory*
        Get-WmiObject -class Win32_PhysicalMemory
        Get-CimInstance -ClassName Win32_PhysicalMemory
        Get-CimInstance -ClassName Win32_PhysicalMemory | Select Tag,Capacity


# Demo: Working with Network Information
    # Run these commands in Windows PowerShell console as Administrator

    # Running ipconfig in Windows PowerShell
        ipconfig                                                                                 
        ipconfig /all
        ipconfig | gm
            #Note: No properties are displayed since command.exe executables linke ipconfig do not pass objects                                                                       
    
    # Accessing IP Address information
        Get-Command get-NetIP*                                                                                
        Get-NetIPAddress                                                                         
        Get-NetIPConfiguration

    # Accessing DNS Client Information
        GCM get-*DNS* 
        GCM get-DNSClient*                                                                  
        Get-DnsClient                                                                                                                                              
        Get-DnsClientCache                                                                                                                                              
        Get-DnsClientServerAddress                                                               

    #Map a Network Drive using Server Message Block (SMB)
        Get-Command *SMB*
        Get-Command *SmbMapping                                                                        
        Help New-SmbMapping -examples
        New-SMBmapping -localPath w: -remotepath \\DC01\Share
        Get-smbmapping
        cd w:\
        dir
        #Note: In the lab environment, the directory listing will have a different set of files and directories than the video demo

# Demo: Reviewing Event Log Information

    # Run these commands in Windows PowerShell console as Administrator

    # Retrieve Last Boot time from Event Logs using event 1074
        get-command get-*Event*
        help get-eventlog -Examples
        get-eventlog -LogName System | gm

    # Note: The video demo runs each command below line by line.
    # To issue commands, type each line and issue 'Enter' after each pipe symbol.
        Get-EventLog -log system -newest 1000 |
        where-object {$_.eventid -eq '1074'} |
        format-table machinename, username, timegenerated -autosize

# Demo: Using Get-ComputerInfo

    # Run these commands in Windows PowerShell console as Administrator

    # Retrieve memory information with Get-ComputerInfo
        help Get-ComputerInfo
        help Get-ComputerInfo -Examples
        Get-ComputerInfo | more
        Get-ComputerInfo -Property *memory*

# Demo: Working with Files and Directories
    # Run these commands in Windows PowerShell console as Administrator
    # Note: Files and directories in lab environment may be different than the video demo

    # Searching the Windows File system for .PNG files
        Help get-childitem
        Get-ChildItem -Path c:\windows\web -Recurse
        Get-ChildItem -Path c:\windows\web -Recurse | gm
        Get-ChildItem -Path c:\windows\web -Recurse | where Extension -EQ '.PNG'
        Get-ChildItem -Path c:\windows\web -Recurse | where Extension -EQ '.PNG' | ft Directory,Name,LastWriteTime

    # Copying Files
        Gcm *copy*
        help Copy-Item -Examples
        copy-item c:\windows\web -Destination c:\CopiedFolder -Recurse -Verbose
        dir c:\CopiedFolder -recurse

    # Moving files  
        move-item c:\CopiedFolder -Destination c:\MovedFolder -verbose
        dir c:\MovedFolder -Recurse
        Rename-Item c:\MovedFolder -NewName c:\RenamedFolder
        dir c:\
