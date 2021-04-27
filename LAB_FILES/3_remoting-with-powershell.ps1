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
    # Lab environment is configured for remote management
    # Commands below for reference to video only
    # Enable PSRemoting on clients
        # Enable-PSRemoting -force

    # Add groups to local security
        # Set-PSSessionConfiguration -Name Microsoft.PowerShell -ShowSecurityDescriptorUI

    # Firewall changes for WMI and Remote Service Management
        # Get-NetFirewallRule | Where-Object -Like "Windows Management Instrumentation*" | Set-NetFirewallRule -Enabled True -Verbose

        # Get-NetFirewallRule | Where-Object -Like "Remote Service Management" | Set-NetFirewallRule -Enabled True -Verbose
    
    # Run these commands in Windows PowerShell console as Administrator

    # Verify Access to DC01
        Get-Service -computername DC01

    # Enter remote PS Session
        Enter-PSSession -ComputerName DC01

    # Commands on remote system
        Get-Service
        Exit

# Demo: Working with Variables
    # Run these commands in Windows PowerShell console as Administrator
 
    # Viewing built-in environment variables in current console
        Get-ChildItem ENV: | more
        $env:Computername
    
    # Viewing PowerShell-specific variables
        Get-Variable | More

    # Viewing Version of PowerShell
        $PSVersionTable

    # Create variable for remote computer
        $ComputerName = “DC01”
        $ComputerName
        Write-Output "The name of the remote computer is $computername"
        Write-Output 'The name of the variable for the remote computername is $computername'

    # Store credentials in a variable
        # When prompted for credentials, use company\administrator and password from the ./LAB_FILES/companypw.txt file
        $credential = Get-Credential
        $credential

    # Run these commands in PowerShell 7 console as Administrator
    
    # Store credentials in PowerShell 7
        # For username and password use:
            # Username: Administrator
            # Password is located in ./companypw.txt in LAB_Files
        
        $credential
            # No response as variables are stored in scope of console
        $cred = Get-Credential
        $cred

    # Run these commands in Windows PowerShell console as Administrator
    
    # Use variable for Computername
        Get-Variable -Name c*
        Get-Service -ComputerName $computername

# Demo: Remoting with PowerShell
    # Run these commands in Windows PowerShell console as Administrator    
    
    #Using -Computername parameter for remote information
        $ComputerName = "DC01"
        Get-Service –computername $ComputerName
            # Note: All PowerShell cmdlets do not support -computername

    #Create a PowerShell session for a remote system
        # For username and password use:
            # Username: Administrator
            # Password is located in ./companypw.txt in LAB_Files

        Get-Command *-PSSession    
        $credential = Get-Credential
        New-PSSession -ComputerName $ComputerName -Credential $credential

    # Access PSSession
        # Session Name and Id values may be different. Enter value in console output. 
        
        #neter
        Enter-PSSession -Name WinRM1 # Enter value in console output. 
            # Commands on Remote System
            $env:Computername
            exit
        Get-PSSession

        # Enter PSSession with Id number
        Enter-PSSession -Id 1 # Enter value in console output. 
            # Commands on Remote System
            $env:Computername
            exit
        Remove-PSSession -id 1 #Enter value in console output. 
        Get-PSSession

# Demo: Remoting with Invoke-Command
    # Run these commands in Windows PowerShell console as Administrator 
    
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
            #Note: This fails since you cannot pass variables to remote systems
    
    # Passing variable to remote syste with Using:
        invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $using:ComputerName }

    # More Information on $using in help
        help about_Remote_Variables

    # Adding remote computer data to variable
        $data =  invoke-command -ComputerName $ComputerName -Credential $credential -ScriptBlock { get-service -ComputerName $using:ComputerName }
        $data | get-member

    # Run these commands in PowerShell 7 console as Administrator
    
    # Running Remote Commands
        # For username and password use:
            # Username: Administrator
            # Password is located in ./companypw.txt in LAB_Files
        invoke-command -ComputerName DC01 -cred (get-credential) -ScriptBlock { Get-ADUser -Identity felixb | format-list }

# Demo: Remoting with New-CimSession
    # Run these commands in Windows PowerShell console as Administrator 
    
    # Help with New-Cimsession
        # For username and password use:
            # Username: Administrator
            # Password is located in ./companypw.txt in LAB_Files
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
