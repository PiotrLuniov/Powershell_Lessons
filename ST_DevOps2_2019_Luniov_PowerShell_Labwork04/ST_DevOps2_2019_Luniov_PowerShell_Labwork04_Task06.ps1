#6.	Вывести свободное место на локальных дисках. На каждом и сумму.

$localdisks=Get-WMIObject Win32_LogicalDisk |where {$_.description -eq "Local Fixed Disk"}
$localdisks | ForEach-Object {$Totalsumm+=$_.freespace} 
#вывод информации на экран
Write-Host "Свободное место на локальных дисках" 
$localdisks |fl caption,freespace
Write-Host "Сумма свободного места на локальных дисках $Totalsumm " 

