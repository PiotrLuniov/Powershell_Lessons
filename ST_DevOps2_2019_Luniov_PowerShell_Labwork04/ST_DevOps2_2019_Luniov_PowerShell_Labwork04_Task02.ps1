# 2. Получить список всех пространств имён классов WMI. 

Get-WMIObject -namespace "root" -class "__Namespace"| Select-Object Name

