# 1.4.Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)

# Вводим два параметра для скрипта - путь к папкам и исключаемое расширение.

[Cmdletbinding()]
Param (

        [parameter(Mandatory=$true, HelpMessage="Enter filepath")]
                [string]$Path,
                [string]$Fileexc= "*.tmp"
                )

Get-Childitem $Path -Exclude $Fileexc -Recurse |where {-not $_.Psiscontainer} |Measure-Object -Property Length -Sum
