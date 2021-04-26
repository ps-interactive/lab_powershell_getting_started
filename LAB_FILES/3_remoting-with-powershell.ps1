# Lab 2 - PowerShell: Getting Started
# Module - Remoting with PowerShell

##### Notes and helpful Items - PLEASE READ #####
# USE ALT+Z to toggle Word Wrap on the remarks for easier reading in VS Code.

# Unless specified, Windows PowerShell and PowerShell 7 consoles need to be launced as Administrator using 'run as administrator' option by right-clicking icon.

# The lab environment has a single client (Client01) and a domain controller (DC01).

# The lab environment has no internet access so actions requiring the Internet will not be performed.

# All remote actions performed with Client as a target in the video course demos will be performed with DC01 instead.

# The commands below are not intended to be run in VS Code. They are intended to be type (preferred) or copy/pasted into the PowerShell console used in each demo.

# Read all of the remarks (hash-tagged green lines) as non-command steps and information is included throughout this script.

# Some demo commands have been modified to work within the lab environment. They will perform the same general tasks, but may have different references such as file directories. Also, any tasks requiring internet access will be skipped.

# Use of cls in code is to clear-host or clear the screen during demos. This can be skipped during your labs if desired.

### Challenge begins here###

# Demo: Requirements for Remoting on Windows PowerShell
    # Run these commands in Windows PowerShell console as Administrator
    # Note: Trusted Hosts has already been set on clients
    
    # Verify trusted hosts on client01
        get-item WSMan:\localhost\client\TrustedHosts -Value *

    # Verify Access to DC01
        get-service -computername DC01

# Demo: Working with Variables
    # Viewing Variables in current console
        Get-ChildItem ENV: | more
        $env:Computername
        Get-Variable | More

    # Viewing Version of PowerShell
        $PSVersionTable

    # Create variable for remote computer
        $ComputerName = “DC01”
        $ComputerName
        Write-Output "The name of the remote computer is $computername"
        Write-Output 'The name of the variable for the remote computername is $computername'

    #Store credentials in a variable
        $credential = Get-Credential
        $credential
        Get-Variable -Name c*
        Get-Service -ComputerName $computername

# Demo: Remoting with PowerShell
    #Using -Computername parameter for remote information
        Get-Service –computername $ComputerName | select Name,Status
            # Note: All PowerShell cmdlets do not support -computername

    #Using PSSession
        Gcm *-PSSession

    #Create a PowerShell session for a remote system
        $ComputerName = “DC01”
        $credential = Get-Credential
        New-PSSession -ComputerName $ComputerName -Credential $credential

    # Working with PSSession
        Enter-PSSession -Name $ComputerName
        Get-PSSession
        Enter-PSSession -Id 2
        Get-PSSession
        Remove-PSSession -id 2
        Get-PSSession

# Demo: Remoting with Invoke-Command
    # Help with Invoke-Command
        help Invoke-command
        $ComputerName = "DC01"

    # Storing Credentials in a variable
        # For username and password use:
            # Username: Administrator
            # Password is located in ./companypw.txt in LAB_Files
        $credential = Get-Credential

    # Running get-service on remote system
        Invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $ComputerName }
            #Note: This fails since you cannot pass variables to remote systems in this manner
    
    # Passing variable to remote syste with $using:
        invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $using:ComputerName }

    # More Information on $using in help
        help about_Remote_Variables

    # Working with remote computer data
        $data =  invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $using:ComputerName }
        $data | gm
        $Data | Select Name,Status,Description

    #On PowerShell 7 
    # Running Remote Commands
        invoke-command -ComputerName DC01 -cred (get-credential) -ScriptBlock { Get-ADUser -Identity felixb | format-list }

# Demo: Remoting with New-CimSession
    
    # Help with New-Cimsession
        $ComputerName = 'DC01'
        $credential = Get-Credential
        Help New-Cimsession

    # Storing CIM Session in variable
        $cimsession = New-CimSession -ComputerName $ComputerName -Credential $Credential
        $cimsession

    # View available CIM sessions
        Get-CimSession

    # Accessing DNS Client on remote system
        Help Get-DNSClientServerAddress
        Get-DNSClientServerAddress -CimSession $CimSession
