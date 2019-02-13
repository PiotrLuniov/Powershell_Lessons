# 1.3 Вывести список из 10 процессов занимающих дольше всего процессор.Результат записывать в файл.

[Cmdletbinding()]

Param (

        [parameter(Mandatory =$true,HelpMessage ="Quantity of processes")]
        [int]$Quantity,
        [parameter(Mandatory=$true)]
        [string]$FilePath

        )
Get-Process |Sort-Object TotalProcessorTime  | Select-Object ProcessName,TotalProcessorTime -Last $Quantity | Out-File $FilePath

