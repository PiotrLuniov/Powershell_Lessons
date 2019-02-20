# 1.5.	Удалить шару из п.1.4

(Get-WmiObject -Class Win32_Share -ComputerName . -Filter "Name='Share'").InvokeMethod("Delete",$null)


