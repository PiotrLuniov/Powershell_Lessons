#1.	Вывести список всех классов WMI на локальном компьютере. 

Get-WmiObject -List

# 2. Получить список всех пространств имён классов WMI. 

Get-WMIObject -namespace "root" -class "__Namespace"| Select-Object Name

#3.	Получить список классов работы с принтером. 

Get-WMIObject -List *Printer* | Select-Object Name

#4.	Вывести информацию об операционной системе, не менее 10 полей. 

Get-WMIObject Win32_OperatingSystem | Format-List Name,BootDevice,BuildNumber,Caption,CodeSet,CountryCode,Locale,Status,Version,WindowsDirectory

#5.	Получить информацию о BIOS

Get-WMIObject Win32_BIOS 

#6.	Вывести свободное место на локальных дисках. На каждом и сумму.

$localdisks=Get-WMIObject Win32_LogicalDisk |where {$_.description -eq "Local Fixed Disk"}
$localdisks | ForEach-Object {$Totalsumm+=$_.freespace} 
#вывод информации на экран
Write-Host "Свободное место на локальных дисках" 
$localdisks |fl caption,freespace
Write-Host "Сумма свободного места на локальных дисках $Totalsumm " 

#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.

[int]$t = $null
Test-Connection "192.168.0.233" | foreach {$t += $_.ResponseTime}
Write-Host "Ping time: $t ms"

#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.

Get-WmiObject Win32_Product |Format-Table Name,Version

# 9.	Выводить сообщение при каждом запуске приложения MS Word.

Register-WmiEvent -query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='winword.exe'" -sourceIdentifier "ProcessStarted2" -Action { Write "Word is Running!" }





