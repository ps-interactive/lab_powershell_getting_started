#Get-ServiceExamplept3.ps1

#Region Step 3 Parameterize Variable
# Create $computername parameter that is mandatory and allows multiple inputs
param (
    [Parameter(Mandatory=$True)]
    [string[]]
    $Computername
)

#Enter Script Block Here
get-service -ComputerName $Computername   |
                         Where-Object -Property Status -eq 'Stopped'