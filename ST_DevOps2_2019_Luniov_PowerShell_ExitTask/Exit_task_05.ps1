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



 

