# 4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб. 

Get-Service | Where-Object {$_.Status -eq "running"}  | Out-File "Surname:\Services.txt" 

# Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.

Get-ChildItem "Surname:\"
Get-Content "Surname:\Services.txt"



