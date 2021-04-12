Member Enumeration of Objects
$OS= Get-CimInstance Win32_OperatingSystem | select Caption
$OS
$OSv2 = (Get-CimInstance Win32_OperatingSystem).Caption