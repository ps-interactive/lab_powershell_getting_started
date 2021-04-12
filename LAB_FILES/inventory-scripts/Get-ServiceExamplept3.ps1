#Get-ServiceExamplept3.ps1

#Region Step 3 Parmeterize Variable
# Parameter help description
param (
    [Parameter(Mandatory=$True)]
    [string[]]
    $Computername
)

#Enter Script Block Here
get-service -ComputerName $Computername   |
                         Where-Object -Property Status -eq 'Stopped'