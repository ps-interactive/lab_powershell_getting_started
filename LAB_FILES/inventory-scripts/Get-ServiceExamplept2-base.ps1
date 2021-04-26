# step 2 Add Variables
$Computername = "Client02"
get-service -ComputerName $Computername   |
                         Where-Object -Property Status -eq 'Stopped'

