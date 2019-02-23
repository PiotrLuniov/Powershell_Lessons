#4.	Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно). Перечень имен компьютеров должен браться из текстового файла. Вывод организовать следующим образом: Имя компьютера – статус (если служба запущена, то строка зелёная, иначе красная)

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
