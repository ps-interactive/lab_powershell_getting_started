# Module - PowerShell Basics
# URL: 

# In this challenge, you will learn how to use various commands in PowerShell to explore the console, and find the information you are looking for. PowerShell's command line interface is built to provide you the information you need through exploration and use of the commands in the console.
# Using this exploratory approach will deepen your understanding of how PowerShell works and allow you to find answers without always searching on the web for them.

##### Notes and helpful Items - PLEASE READ #####
# USE ALT+Z to toggle Word Wrap for better text viewing in VS Code!!!

# Unless specified, Windows PowerShell and PowerShell 7 consoles need to be launced as Administrator using 'run as administrator' option by right-clicking icon.

# The lab environment has a single client (Client01) and a domain controller (DC01).

# The lab environment has no internet access so actions requiring the Internet will not be performed.

# All remote actions performed with Client02 as a target the video course demos will be performed with DC01 instead.

# The commands below are not intended to be run in VS Code. They are intended to be type (preferred) or copy/pasted into the PowerShell console used in each demo.

# Read all of the remarks (hash-tagged green lines) as non-command steps and information is included throughout this script.

# Some demo commands have been modified to work within the lab environment. They will perform the same general tasks, but may have different references such as file directories. Also, any tasks requiring internet access will be skipped.

# Use of cls in code is to clear-host or clear the screen during demos. This can be skipped during your labs if desired.

#IMPORTANT: Prior to beginning this lab, make sure you have completed the setup tasks in ./0_Start-Here-setup-lab.ps1!!
#####

# Demo: 
# Run these commands in Windows PowerShell
#In this challenge, you will walk through the demo from the beginning of the course. The demo walks you through creating a .csv report of all the stopped services on a remote server. While you may not know what the commands are doing yet, this will get you hands on with PowerShell, and get you practice typing commands into the console.

# Introduction to PowerShell
# Demo: Using PowerShell to Report on Stopped Server Services

# Run these commands in Windows PowerShell console
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
$data | out-file .\services.csv                  
notepad .\services.csv                                                                                               

# Export variable data to a .csv file
$data | export-csv .\Services2.csv
                    
get-content .\services2.csv | more  

# Demo: Exploring PowerShell Verbs
#In this first challenge, you will explore get-verb from the PowerShell console. PowerShell uses a Verb-Noun syntax so it's important that you learn the common verbs in PowerShell like get and set. 
#Remember in PowerShell: Almost everything you need to know, you can find out through the shell. Just type and Explore.

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
    #Note: The -group parameter is only available in PowerShell 7 so it will not work if you are using Windows PowerShell.

    #Type Exit to close the PowerShell 7 console, or leave it open if you plan to do the next challenge.
    Exit

    # Broken
    start https://aka.ms/psverbs

    # View Approved Verbs for Powershell doc at docs.microsoft.com.
    # Try https://bit.ly/psverbs

#Demo: Working with Aliases and Parameters
# In this lab, you'll get experience using aliases and positional parameters in PowerShell. 

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
#Demo 2 - Working with Help
    # Run as a normal user with PowerShell 7
    
    # Using Get-Help without help updated
    get-help                           
    help                  
    get-help *Service* | more                        
    help get-service            

    # Open PowerShell 7 and Run as Administrator (right-click icon)
    # Updating PowerShell 7
    
    update-help -SourcePath "c:\users\administrator\desktop\Lab_Files\pshelp"

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
    Help get-command 
    Help Get-Command -examples
    get-command | more
    Ctrl + C
    get-command -verb New
    get-command -CommandType Function | measure-object
    
    #You are looking for a command to work with IP Address Configurations on a Windows System
    get-command -name *IP* | More
    get-command -Name *IP* -Module Net*
    Get-command -Name *IP* -Module NetTCPIP
    Help Get-NetIPAddress 
    Help Get-NetIPAddress -Examples
    Get-NetIPAddress


## Demo: Documenting Your Work in the PowerShell Console
#Demo 4 - Using History and Transcript

    # setup commands
    Md c:\scripts\transcripts
    cd c:\scripts
    #cd c:\scripts

    #working with get-history
    Help get-history
    Get-history

    #For this command choose an id number from your history 
    invoke-history -id 24

    # Sending get-history output to a text file and viewing in notepad and vscode
    Get-History | Out-File c:\scripts\transcripts\history.txt
    notepad c:\scripts\transcripts\history.txt
    code .\transcripts\history.txt
    #Code c:\scripts\transcripts\history.txt

    Clear-History
    Get-History

    # Working with start-transcript
    Help Start-Transcript
    Start-Transcript -path .\transcripts\transcript1.txt -Append
    Get-service | Where-Object -Property Status -EQ Stopped
    Stop-transcript
    code .\Transcripts\transcript1.txt
    Notepad .\Transcripts\transcript1.txt

# Demo: Finding Object Properties with Get-Member
# Open Windows PowerShell from the Start Menu using Run As Administrator

    Help Get-Member
    Get-service | Get-Member
    #Add -computername to commands ?
    Get-service | Select-Object Name,MachineName,Status
    Get-Service | Select-Object Name,MachineName,Status | Get-Member
    Get-Service | Where-Object status -eq "Stopped" | More

    Get-Service -ComputerName Client01,DC01 |
    >> Where-Object status -eq "Stopped" |
    >> Select-Object Name,MachineName,Status |
    >> Sort-Object -Property MachineName | More


# Not sure where this is from - Not in Module 3
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
