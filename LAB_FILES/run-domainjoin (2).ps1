# This script will add your client computer into the company.co domain in the Lab environment.
# Due to technical reasons, the client will auto-logon with the local administrator account upon reboot.
# When required, domain credentials will be provided with commands to perform certain actions

# Join computer to domain using password from c:/companypw.txt
add-computer -domain company.co -server DC01 -credential (Get-credential -Message "Enter Administrator and password from the file c:\companypw.txt. Computer will automatically restart.") -force -verbose -restart | out-file "c:\logging.txt" -append
