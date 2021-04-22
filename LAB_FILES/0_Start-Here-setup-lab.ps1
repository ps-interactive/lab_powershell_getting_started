# Setup
# Add Client01 to Domain
    # Steps
    # 1) In the Lab_Files folder, right-click run-domainjoin.ps1 and choose 'Run as administrator'
    # 2) When prompted, enter username of Administrator and password from the companypw.txt file
    # 3) After completing, Client01 will reboot

# Add update-help in PowerShell 7 with local files
    # Steps
    # 1) Right-click PowerShell 7 icon on the desktop and choose 'Run as administrator'
    # 2) Enter the following command:
        update-help -SourcePath "c:\users\administrator\desktop\Lab_Files\pshelp"
            #Note: there will be some errors for non-updating modules. That is normal.