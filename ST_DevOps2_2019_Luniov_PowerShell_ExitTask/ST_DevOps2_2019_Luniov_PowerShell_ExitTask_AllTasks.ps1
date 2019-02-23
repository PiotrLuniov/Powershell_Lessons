#1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. Результат представить в виде файла XML.
Get-EventLog -LogName System -EntryType Error | where {$_.TimeGenerated.Date -ge (Get-Date).Adddays(-7).Date} | Export-Clixml -Path c:\errors.xml

# 2.	Вывести список файлов *.log хранящихся в папке C:\Windows. Вывод организовать в виде таблицы с обратной сортировкой по имени файла, при этом выводить полное имя файла, размер файла, время создания. 
Get-ChildItem c:\windows\*.log  | Sort-Object Name -Descending |Format-Table FullName, Length, CreationTime -AutoSize 

# 3.	Создать файл-сценарий вывода всех чисел делящихся без остатка на 3, на интервале от А до В, где А и В — входные параметры, параметр А по умолчанию равен 0, параметр В обязателен для ввода.
Param (
        [cmdletBinding()]
        [int]$a=0,
        [parameter(Mandatory=$true)]
        [int]$b
      )
        $c=$a..$b
        foreach ($i in $c) {
            if($i%3 -eq 0 -and $i -ne 0) {
                Write-Host $i
            }
        }

# 4.	Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно). Перечень имен компьютеров должен браться из текстового файла. Вывод организовать следующим образом: Имя компьютера – статус (если служба запущена, то строка зелёная, иначе красная)

New-Item -ItemType File -Path c:\servers.txt
Set-Content -Path c:\servers.txt -Value "VM1","VM2" 
$servers = Get-content C:\servers.txt
$inv=Invoke-Command -ScriptBlock{Get-Service -Name Spooler} -ComputerName $servers 
foreach ($i in $inv) { 
        if ($i.status -eq "Running"){ 
            Write-Host $i.PScomputerName - $i.name - $i.Status -f Green
        }
        else {
            Write-Host $i.PScomputerName - $i.name - $i.Status -f Red
        }
}

#5.	Все файлы из прилагаемого архива перенести в одну папку, не содержащую подпапок. Имя каждого файла изменить, добавив в его начало имя родительской папки и время переноса файла. В конце выдать отчёт о количестве файлов и общем размере перенесённых файлов. 

Add-Type -AssemblyName "System.IO.Compression.FileSystem"
$ArchiveFileName = 'D:\EPAM_Study\Module 2 - Automating Administration with Windows PowerShell 2.0 (Introduction).zip'
# Путь, куда разархивировать
$ExtractPath = 'D:\unzip'
# Разархивируем
[IO.Compression.ZipFile]::ExtractToDirectory($ArchiveFileName, $ExtractPath)

$files=get-childitem D:\Unzip2 -Recurse -File 

foreach($file in $files ) {

    $newname = $($file.Directory.Name) +$($file.CreationTime.ToString() -replace "[/: ]") +$($file.Extension)
    Rename-Item -Path $file.Fullname -newname $newname 
}

$files |Measure-Object  -Property Length -sum |Format-table @{Name="sum,Mb"; Expression ={$([math]::Round($_.sum/1mb, 1))}},@{Name="COUNT";Expression={$_.count}} -AutoSize



 


