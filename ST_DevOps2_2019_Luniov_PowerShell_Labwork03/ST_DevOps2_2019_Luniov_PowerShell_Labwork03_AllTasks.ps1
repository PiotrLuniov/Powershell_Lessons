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

# 1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
 
 #Не нашёл подходящего решения - Get-ChildItem env: - позволяет получить список Windows переменных,но получить их значение уже не удается..
 #вычисление всех переменных сеанса проходит так

 Get-Variable | Where-Object {$_.Value -and $_.Value.GetType().Name -eq "Int32"}|Measure-Object -Property Value -Sum 

# 1.3 Вывести список из 10 процессов занимающих дольше всего процессор.Результат записывать в файл.

[Cmdletbinding()]

Param (

        [parameter(Mandatory =$true,HelpMessage ="Quantity of processes")]
        [int]$Quantity,
        [parameter(Mandatory=$true)]
        [string]$FilePath

        )
Get-Process |Sort-Object TotalProcessorTime  | Select-Object ProcessName,TotalProcessorTime -Last $Quantity | Out-File $FilePath

# 1.3.1 Организовать запуск скрипта каждые 10 минут

# Как необязательный параметр указываем путь к файлу, запускающемуся по расписанию - по умолчанию запускается скрипт из родительской папки.

Param (
        [string]$File=".\ST_DevOps2_2019_Luniov_PowerShell_Labwork03_Task01_03.ps1"
      )

$t= New-JobTrigger -Once -At 4:30PM -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration (New-TimeSpan -Days 1)
$cred = Get-Credential corp\lunev
$o = New-ScheduledJobOption -RunElevated
Register-ScheduledJob -Name Start -FilePath $File -Trigger $t -Credential $cred -ScheduledJobOption $o

# 1.4.Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)

# Вводим два параметра для скрипта - путь к папкам и исключаемое расширение.

[Cmdletbinding()]
Param (

        [parameter(Mandatory=$true, HelpMessage="Enter filepath")]
                [string]$Path,
                [string]$Fileexc= "*.tmp"
                )

Get-Childitem $Path -Exclude $Fileexc -Recurse |where {-not $_.Psiscontainer} |Measure-Object -Property Length -Sum

# 1.5.	Создать один скрипт, объединив 3 задачи:
# 1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
# 1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
# 1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разными цветами
 
[Cmdletbinding(PositionalBinding=$false)]

Param (
           [parameter(Mandatory=$true,HelpMessage="Path for CSV-file",Position=0)]
           [string]$PathCSV,
           
           [parameter(Mandatory=$true,HelpMessage="Path for XML-file",Position=1)]
           [string]$PathXML

       )
 

Get-WmiObject Win32_QuickFixEngineering | where {$_.description -eq "Security Update"} |Select-Object Description, HotfixId,InstalledOn |Export-Csv $PathCSV
Get-Item HKLM:\Software\Microsoft\* |Select-Object Name | Export-Clixml -Path $PathXML
Import-Csv $PathCSV  | Write-Host -f Red 
Import-Clixml $PathXML  | Write-Host -f Green 

#2.	Работа с профилем

#2.1.	Создать профиль
New-Item -ItemType File -Path $profile -Force

# Начинаем редактирование созданного файла-профиля.

#2.2.	В профиле изменить цвета в консоли PowerShell
 (Get-Host).UI.RawUI.ForegroundColor = "Red"
 (Get-Host).UI.RawUI.BackgroundColor = "Black"

#2.3.	Создать несколько собственных алиасов
Set-Alias -Name "WMI" -Value Get-WmiObject
Set-Alias -Name "Gprocess" -Value Get-Process

#2.4.	Создать несколько констант
$systemprocess = Get-Process -Name System
$diskC = Get-ChildItem -Path C:\

#2.5.	Изменить текущую папку
Set-Location C:\

#2.6.	Вывести приветствие
Write-Host "Hello, buddy!"

#2.7.	Проверить применение профиля

# Проверено - работает!

# 3.	Получить список всех доступных модулей

Get-Module -ListAvailable
