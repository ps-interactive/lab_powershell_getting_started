#Step 1 Run HardCoded command
get-service -ComputerName DC01   |
                         Where-Object -Property Status -eq 'Stopped'




