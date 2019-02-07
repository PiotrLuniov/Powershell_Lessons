# 9. Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.

Get-Item HKLM:\SOFTWARE\Microsoft\* |Select-Object Name |Export-Csv -Path C:\Reg_info.csv 
