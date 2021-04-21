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