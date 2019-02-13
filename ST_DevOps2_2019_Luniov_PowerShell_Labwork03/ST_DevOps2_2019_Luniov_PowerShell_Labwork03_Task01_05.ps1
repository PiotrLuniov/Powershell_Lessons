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

