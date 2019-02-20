# 1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.

$servers =@("VM1","VM2")
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=TRUE and DHCPEnabled=False" -ComputerName $servers -Credential corp\sysdba  | Invoke-WmiMethod -Name EnableDHCP

# Проверяем состояние появившихся клиентов DHCP
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=TRUE and DHCPEnabled=True" -ComputerName $servers -Credential corp\sysdba 

#На выходе получаем DHCPenable на двух машинах
#Description       : Virtual Ethernet Adapter01
#DHCPEnabled       : True
#DHCPLeaseExpires  : 20190219103016.000000+180
#DHCPLeaseObtained : 20190219100016.000000+180
#DHCPServer        : 192.168.96.254
#Index             : 24

#Description       : Virtual Ethernet Adapter01
#DHCPEnabled       : True
#DHCPLeaseExpires  : 
#DHCPLeaseObtained : 
#DHCPServer        : 255.255.255.255
#Index             : 29
