#Measure
Get-CimInstance Win32_PhysicalMemory -ComputerName Client02
(Get-CimInstance Win32_PhysicalMemory -ComputerName Client02).Capacity
(Get-CimInstance Win32_PhysicalMemory -ComputerName Client02).Capacity | measure -Sum
(((Get-CimInstance Win32_PhysicalMemory -ComputerName Client02).Capacity | measure -Sum).Sum)
((((Get-CimInstance Win32_PhysicalMemory -ComputerName Client02).Capacity | measure -Sum).Sum)/1gb)
