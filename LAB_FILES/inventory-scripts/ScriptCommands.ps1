#OS Description
    $OS= (Get-CimInstance Win32_OperatingSystem -ComputerName Client02).caption
    $OS

#Disk Freespace on OS Drive 
   $drive = Get-WmiObject -class Win32_logicaldisk | Where-Object DeviceID -EQ 'C:'
   $Freespace = (($drive.Freespace)/1gb)
   $drive
   $freespace

#Amount of System Memory
   $MemoryInGB = ((((Get-CimInstance Win32_PhysicalMemory -ComputerName Client02).Capacity|measure -Sum).Sum)/1gb)
   $MemoryInGB

#Last Reboot of System
   $LastReboot = (Get-CIMInstance -Class Win32_OperatingSystem –ComputerName Client02).LastBootUpTime      
   $LastReboot

#IP Address & DNS Name
   $DNS = Resolve-DnsName -Name Client02 | Where-Object Type -eq "A" 
   $DNSName = $DNS.Name
   $DNSIP = $DNS.IPaddress 
   $DNS
   $DNSName
   $DNSIP

#DNS Server of Target
   $CimSession = New-CimSession -ComputerName Client02 -Credential (Get-Credential)
   (Get-DNSClientServerAddress -cimsession $CimSession -InterfaceAlias "ethernet" -AddressFamily IPv4).ServerAddresses