$Computername = "mb-ps-ws01"
$MemoryInGB = ((((Get-CimInstance Win32_PhysicalMemory -ComputerName $Computername).Capacity|measure -Sum).Sum)/1mb)
