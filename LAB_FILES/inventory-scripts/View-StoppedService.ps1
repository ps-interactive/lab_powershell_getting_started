# Script for viewing stopped services on a windows client
# Run in Windows PowerShell only

$computername=Read-host -Prompt "Enter name of host"

$stoppedService = get-service -ComputerName $computername   |
                        Where-Object -Property Status -eq 'Stopped'

Write-Output $stoppedService
