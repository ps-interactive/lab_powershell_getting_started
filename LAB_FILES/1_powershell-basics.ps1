# Lab 1 - PowerShell: Getting Started
# Courses: Introduction to PowerShell and PowerShell Basics

##### Notes and helpful Items - PLEASE READ #####
# USE ALT+Z to toggle Word Wrap on the remarks for easier reading in VS Code.

# Unless specified, Windows PowerShell and PowerShell 7 consoles need to be launced as Administrator using 'run as administrator' option by right-clicking icon.

# The lab environment has a single client (Client01) and a domain controller (DC01).

# The lab environment has no internet access so actions requiring the Internet will not be performed.

# All remote actions performed with Client02 as a target in the video course demos will be performed with DC01 instead.

# The commands below are not intended to be run in VS Code. They are intended to be type (preferred) or copy/pasted into the PowerShell console used in each demo.

# Read all of the remarks (hash-tagged green lines) as non-command steps and information is included throughout this script.

# Some demo commands have been modified to work within the lab environment. They will perform the same general tasks, but may have different references such as file directories. Also, any tasks requiring internet access will be skipped.

# Use of cls in code is to clear-host or clear the screen during demos. This can be skipped during your labs if desired.

#IMPORTANT: Prior to beginning this lab, make sure you have completed the setup tasks in ./0_Start-Here-setup-lab.ps1!!
#####

### Challenge begins here###

# Pre-Lab Setup Steps - Complete before starting labs!!!
    # Add Client01 to Domain of company.co
        # Steps
        # 1) In the Lab_Files folder, right-click run-domainjoin.ps1 and choose 'Run with PowerShell'.
        # 3) After completing, Client01 will reboot and you may continue with the lab challenges.

    #Update Help in PowerShell 7
        # Steps
        # 1) Right-click PowerShell 7 icon and choose 'Run as administrator' option.
        # 2) Enter the following command and close console when completed:
            update-help -SourcePath "c:\users\administrator\desktop\Lab_Files\pshelp"
            #NOTE: You may receive errors for some updates failing. This is normal and can be ignored.

# Module - Introduction to PowerShell
# Demo: Using PowerShell to Report on Stopped Server Services
    # Run these commands in Windows PowerShell console as Administrator
    # Open Windows PowerShell
    # Right-click on choose 'Run as administrator' on desktop icon

    # View all services on local system                                                                                                                         
        Get-Service

    # View stopped services
        get-service | where-Object Status -eq 'Stopped'

    # View only Name and Status for stopped services                                                  
        get-service | Where-Object Status -eq 'Stopped' | select-object Name,Status 

    # Place command output in a variable
        $data = get-service | Where-Object Status -eq 'Stopped' | select-object Name,Status 
        $data

    # Note the difference between the output files of the two commands below
    # Output variable data to a .csv file
    # View in notepad or VS Code
        $data | out-file .\services.csv                  
        notepad .\services.csv                                                                                               
        code .\services.csv

    # Export variable data to a .csv file
        $data | export-csv .\Services2.csv   
        get-content .\services2.csv | more  

# Demo: Exploring PowerShell Verbs
    # Run these commands in PowerShell 7 console
    #In the console window, type the following command to list all of the verbs available in the Windows PowerShell console, and click the space bar to scroll through each screen
        get-verb | more
            #The command includes | more so all of the output can be reviewed one screen at a time. If you need to exit the output, you can use Ctrl+C to go to the prompt.

    #Type the following command to view all of the commands in PowerShell using the Set verb.
        get-verb -Verb Set | more
            #In the command output, you will see the default formatting of output is as a table.

    #Type the following command to view all of the commands in PowerShell using the set verb and in a list format.
        get-verb -Verb Set | format-list
            #In this command, you pipe "|" the output of the command into format-list to display the output as a list. 

    #Type the following command to view all of the verbs that are part of the Security group.
        Get-Verb -Group Security | Format-List
            #The -group parameter is only available in PowerShell 7 so it will not work if you are using Windows PowerShell.

    #Type Exit to close the PowerShell 7 console, or leave it open if you plan to do the next challenge.
        Exit

    # View Approved Verbs for Powershell doc at docs.microsoft.com.
    # Try https://bit.ly/psverbs
    # This will not work in lab environment due to Internet access restrictions.
    # Launch URL above in a separate browser window

#Demo: Working with Aliases and Parameters
    # Run these commands in Windows PowerShell console as Administrator

    # This command demonstrates gathering information with get-service
        get-service -Name M* -ComputerName Client01,DC01

    # This command displays all aliases avaialable in Powershell console
        Get-Alias | More

    # This command displays
        get-alias -Definition *service*

    # These commands shows the gsv alias in action
        gsv -Name M* -ComputerName Client1,DC01
        help gsv

    # These commands show the use of aliases with positional parameters
        gsv M* -Computername Client01,DC01
        gsv M* -Comp Client1,Dc01


## Demo: Finding Answers in the PowerShell Console
    # Run PowerShell 7 as Administrator

    # Using Help w/ different parameters 
        help get-service
        help get-service -Examples
        help get-service -full
        help get-service -online 

        Man get-service 

    # Viewing about pages
        Help *about*
        Help about_Aliases

## Demo: Researching Commands with Get-Command
    # Run these commands in Windows PowerShell console as Administrator

    # Exploring get-command
        Help get-command 
        Help Get-Command -examples
        get-command | more
        # Enter Ctrl + C to break out of get-command results
    
    # View all commands with the Verb New
        get-command -verb New
        get-command -CommandType Function | measure-object
    
    # Use get-command to find cmdlet for IP Address Configurations on a Windows System
        get-command -name *IP* | More
        get-command -Name *IP* -Module Net*
        Get-command -Name *IP* -Module NetTCPIP
        Help Get-NetIPAddress 
        Help Get-NetIPAddress -Examples
        Get-NetIPAddress

## Demo: Documenting Your Work in the PowerShell Console
    # Run these commands in Windows PowerShell console as Administrator

    # setup commands to create and change directory
        Md c:\scripts\transcripts

    #working with get-history
        Help get-history
        Get-history

    # Use invoke-command to access command from history by ID
    # Note: your history will differ from video demo so choose an id number from your history 
        invoke-history -id 24

    # Sending get-history output to a text file and viewing in notepad and vscode
        Get-History | Out-File c:\scripts\transcripts\history.txt
        notepad c:\scripts\transcripts\history.txt
        code c:\scripts\transcripts\history.txt
    
    # Additional -history commands
        Clear-History
        Get-History

    # Working with start-transcript
        Help Start-Transcript
        Start-Transcript -path c:\scripts\transcripts\transcript1.txt -Append
        Get-service | Where-Object -Property Status -EQ Stopped
        Stop-transcript
        
    # View transcripts in notepad and vs code
        code c:\scripts\transcripts\transcript1.txt
        Notepad c:\scripts\transcripts\transcript1.txt

# Demo: Finding Object Properties with Get-Member
    # Run these commands in Windows PowerShell console as Administrator

    # Explore Get-member cmdlet
        Help Get-Member
        Get-service | Get-Member

    # Viewing objects for get-service
    # Add -computername to commands ?
        Get-service | Select-Object Name,MachineName,Status
        Get-Service | Select-Object Name,MachineName,Status | Get-Member
        Get-Service | Where-Object status -eq "Stopped" | More

    # Putting all the commands together
    # Note: The video demo runs each command below line by line.
    # To issue commands, type each line and issue 'Enter' after each pipe symbol.
        Get-Service -ComputerName Client01,DC01 |
        Where-Object status -eq "Stopped" |
        Select-Object Name,MachineName,Status |
        Sort-Object -Property MachineName | More
