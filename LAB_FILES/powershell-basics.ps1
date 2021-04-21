# Module - PowerShell Basics
# URL: 

# Note: Some demo commands have been modified to work within the lab environment. They will perform the same general tasks, but may have different references such as file directories. Also, any tasks requiring internet access will be skipped.
# Note: Use of cls in code is to clear-host or clear the screen during demos. This can be skipped during your labs if desired.

#IMPORTANT: Prior to beginning this lab, make sure you have completed the setup tasks in ./setup-lab.ps1!!

# Demo: 
# Run these commands in Windows PowerShell
# In this Lab, you will learn how to use various commands in PowerShell to explore the console, and find the information you are looking for. PowerShell's command line interface is built to provide you the information you need through exploration and use of the commands in the console. Using this exploratory approach will deepen your understanding of how PowerShell works and allow you to find answers without always searching on the web for them.
#In this challenge, you will walk through the demo from the beginning of the course. The demo walks you through creating a .csv report of all the stopped services on a remote server. While you may not know what the commands are doing yet, this will get you hands on with PowerShell, and get you practice typing commands into the console.

#cd c:\scripts\m1

# Introduction to PowerShell
# Demo: Using PowerShell to Report on Stopped Server Services

#Open Windows PowerShell
# Right-click on choose 'Run as administrator' on desktop icon

# Run these commands in Windows PowerShell console

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

# demo: Exploring PowerShell Verbs
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

# Setup
# Add Client01 to Domain
    # Steps
    # 1) Open Windows PowerShell as administrator
    # Run the following command:
    add-computer -domain company.co -server dc01.company.co -restart -force
        # When prompted, enter username of Administrator and password from the "file"

# Add update-help in PowerShell 7 with local files
    # Steps
    # 1) Right-click PowerShell 7 icon on the desktop and choose 'Run as administrator'
    # 2) Enter the following command:
    update-help -SourcePath "c:\users\administrator\desktop\Lab_Files\pshelp"
        #Note: there will be some errors for non-updating modules. That is normal.

# Demo: Exploring PowerShell Verbs
#Demo-M2-01
get-verb | more

get-verb -Verb Set | more

get-verb -Verb Set | format-list

Get-Verb -Group Security | Format-List

# Broken
start https://aka.ms/psverbs

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
#Runa as Standard
get-help                           
help                  
get-help *Service* | more                        
help get-service            

#Elevate to Admin
# In labs, already updated
start-process PowerShell -RunAs -Credential (Get-Credential)
update-help

# Using Help w/ different parameters 
help get-service
help get-service -Examples
help get-service -full
help get-service -online 

Man get-service 
Help *about*

# help about_eventlogs

#Add a command showing about file



## Demo: Researching Commands with Get-Command

#Demo 3 - Get Commands
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
notepad .\transcripts\history.txt

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

#Demo 5 - Pipelining and Objects
# Need DNS Name Resolution
Open Windows PowerShell from the Start Menu using Run As Administrator

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
