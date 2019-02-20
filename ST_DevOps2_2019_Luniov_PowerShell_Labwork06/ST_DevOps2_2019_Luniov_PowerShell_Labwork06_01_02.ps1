# 1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property Ipaddress, Description, Macaddress


Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName "Vm1" -Credential corp\sysdba | Select-Object -Property Ipaddress, Description, Macaddress

# На выходе получаем
#Ipaddress       Description                       Macaddress       
#---------       -----------                       ----------       
#{192.168.0.172} Microsoft Hyper-V Network Adapter 00:15:5D:00:DD:04
