
$dcstatus = get-service -ComputerName DC01 -Name Netlogon -ErrorAction SilentlyContinue -Verbose | select-object -Property status -Verbose
write-host $dc_status
$Prop = $dcstatus.status
write-host $prop
#$status = $Prop.Value
#$status
        do {
            #start-sleep -s 60
            write-host "DC status is offline" -Verbose
            $dcstatus = get-service -ComputerName DC01 -Name Netlogon -ErrorAction SilentlyContinue -Verbose | select-object -Property status -Verbose
            $Prop = $dcstatus.status
            start-sleep -s 15
            #$prop
            #$status = $Prop.Value
            #$status
            
        } while ($prop -ne 'Running') 

write-host "Congrats! DC status is $status"
add-computer -domain company.co -server DC01 -credential (Get-credential -Message "Enter Administrator and password from the file c:\companypw.txt") -newname Client01 -force -verbose | out-file "c:\computer-add.txt" -append
restart-computer -Force