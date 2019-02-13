
# 1.1.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб.


[CmdletBinding()]
Param(
    [parameter(Mandatory=$true,HelpMessage='Enter status of service')]
    [string]$Status,
    [parameter(Mandatory=$true)]
    [string]$File
    )   
    

Get-Service | Where-Object {$_.Status -eq "$Status"}  | Out-File "$File" 

# Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.

Get-ChildItem "C:\"
Get-Content "$File"



