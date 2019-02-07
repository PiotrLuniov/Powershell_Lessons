# 1. Просмотреть содержимое ветви реестра HKCU

    # Узнаем имена каталогов в корневом HKCU:\
    Get-Item HKCU:\* | Select-Object Name 

    # Узнаем какие параметры находятся в корневом HKCU:\
    Get-Item HKCU:\  

# 2. Создать, переименовать, удалить каталог на локальном диске
New-Item -ItemType directory -Path "C:\" -Name "2222"
Rename-Item -Path "C:\2222" -NewName "1111"
Remove-Item -Path "C:\1111" 

# 3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
New-Item -ItemType directory -Path "C:\" -Name "M2T2_Luniov"
New-PSDrive -Name "Surname" -PSProvider FileSystem -Root "C:\M2T2_Luniov" 

# 4. Сохранить в текстовый файл на созданном диске список запущенных(!) служб. 
Get-Service | Where-Object {$_.Status -eq "running"}  | Out-File "Surname:\Services.txt" 

    # Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
    Get-ChildItem "Surname:\"
    Get-Content "Surname:\Services.txt"

# 5. Просуммировать все числовые значения переменных текущего сеанса.
Get-Variable | Where-Object {$_.Value -and $_.Value.GetType().Name -eq "Int32"}| Measure-Object -Property Value -Sum 

# 6. Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process |Sort-Object TotalProcessorTime | Select-Object ProcessName, TotalProcessorTime -Last 6  

# 7. Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
Get-Process | ForEach-Object{ 
if ($_.VM/1mb -gt 100) {
Write-Host -f Red $_.ProcessName - $($_.VM/1mb)}
else {
Write-Host -f Green $_.ProcessName - $($_.VM/1mb)}
} 

# 8. Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
$TotalLength=0
Get-ChildItem C:\Windows -Recurse -Exclude *.tmp|Where-Object {-not $_.PSiscontainer} |ForEach-Object {$TotalLength+=$_.Length}
Write-Host $TotalLength 

# 9. Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Get-Item HKLM:\SOFTWARE\Microsoft\* |Select-Object Name |Export-Csv -Path C:\Reg_info.csv 

# 10. Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
Get-History | Export-Clixml -Path c:\test.xml 

# 11. Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.

    # При просмотре св-в импортируемого объекта, оказалось, что их количество равно 5. Так что можно не перечислять их, а поставить * для вывода всех пяти свойств.
    Import-Clixml c:\test.xml | Format-List * 

# 12. Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-PSDrive -Name Surname 
Remove-Item -Path C:\M2T2_Luniov 