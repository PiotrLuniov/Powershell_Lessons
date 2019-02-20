# 1.4.	Расшарить папку на компьютере

New-Item -ItemType Directory -Path C:\share

(Get-WmiObject -List -ComputerName . | Where-Object -FilterScript {$_.Name –eq "Win32_Share"}).InvokeMethod("Create",("C:\share","Share",0,25,"test share"))


