#3.	Получить список классов работы с принтером. 

Get-WMIObject -List *Printer* | Select-Object Name
