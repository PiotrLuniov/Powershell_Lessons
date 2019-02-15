#4.	Вывести информацию об операционной системе, не менее 10 полей. 

Get-WMIObject Win32_OperatingSystem | Format-List Name,BootDevice,BuildNumber,Caption,CodeSet,CountryCode,Locale,Status,Version,WindowsDirectory
