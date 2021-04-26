# Lab 2 - PowerShell: Getting Started
# Module - Building a User Inventory Script with PowerShell

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

### Challenge begins here###

# Demo: Running Scripts in PowerShell
    # Run these commands in Windows PowerShell console as Administrator    
    # For this demo, open the follow scripts in <> and run each line of code along with video
        cd ./lab_files/inventory-scripts
        .\view-StoppedService.ps1
    # Error

    # View exectuion policy
    Get-ExecutionPolicy

    # Set exectuion policy to remote signed
    help Set-ExecutionPolicy -Parameter ExecutionPolicy
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
    
    # Run script
    # Enter DC01 as host name for script
    .\View-StoppedService.ps1 

# Demo: Using PowerShell ISE
    # Run this in Windows PowerShell ISE as Administrator
    # Right-Click Windows PowerShell ISE Icon from desktop
    # For this demo, follow along with the video to view and create scripts in the ISE

# Demo: Using Visual Studio Code
    # Note: The PowerShell VS Code extension are already installed in lab environment
    # Open View-StoppedServices.ps1 from LAB_Files folder on desktop
     code ./lab_files/inventory_scripts/View-StoppedServices.ps1  

# Demo: Working with Script Basics
    # Run these commands in Windows PowerShell and Visual Studio Code as Administrator
    
    # Run get-servicestatus.ps1
    ./lab_files/inventorty_scripts/get-servicestatus.ps1

    # Open script in VS Code to follow along with demo video
    code ./get-servicestatus.ps1

    # When running the script with a computername use DC01

# Demo: Walking Through Parameterized Script Steps
    # Run this lab in Visual Studio Code as Administrator

    # For this demo, open the follow scripts in Visual Studio Code and follow along with video
        code ./Get-ServiceExamplept1-base.ps1
        code ./Get-ServiceExamplept2-base.ps1
        code ./Get-ServiceExamplept3-base.ps1
        code ./Get-ServiceExamplept4-base.ps1
    
    # To review what each script looks like at each stage, open the following in Visual Studio:
        code ./Get-ServiceExamplept1.ps1
        code ./Get-ServiceExamplept2.ps1
        code ./Get-ServiceExamplept3.ps1
        code ./Get-ServiceExamplept4.ps1

Demo: 

# Demo: Building a Remote Information Gathering Script in PowerShell
    # For this demo, open the follow scripts in <> and run each line of code along with video
    code ./ScriptTasks.ps1
    code ./ScriptCommands.ps1
    code ./Get-Memory.ps1
    code ./BaseTemplate.ps1
    code ./Get-helpdesksupportdata.ps1

    # Start following along with the video on ScriptTasks.ps1 and ScriptCommands.ps1
    # This will walk you through each command.
    # Optionally, you can run each of the commands as is done in the video

    # As all of the code is filled in for you in get-helpdesksupportdata.ps1, you can:
        # Review the code live along with the video
        # Copy over portions of the code into the basetemplate.ps1 script, and attempt running it
        # Make changes and see what happens
            # Try Changing line 62 to use mb instead of gb
            # Add additional examples to help files
            # Try changing the output of the script
            # Customize the credential window prompt on line 49
        Use the video and the final script, get-helpdesksupportdata.ps1 as a guide and reference

    # Try making up your own examples while you are here!


