# 1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property IPAddress


# 1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property Ipaddress, Description, Macaddress


Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName "Vm1" -Credential corp\sysdba | Select-Object -Property Ipaddress, Description, Macaddress

# На выходе получаем
#Ipaddress       Description                       Macaddress       
#---------       -----------                       ----------       
#{192.168.0.172} Microsoft Hyper-V Network Adapter 00:15:5D:00:DD:04


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


# 1.4.	Расшарить папку на компьютере

New-Item -ItemType Directory -Path C:\share

(Get-WmiObject -List -ComputerName . | Where-Object -FilterScript {$_.Name –eq "Win32_Share"}).InvokeMethod("Create",("C:\share","Share",0,25,"test share"))


# 1.5.	Удалить шару из п.1.4

(Get-WmiObject -Class Win32_Share -ComputerName . -Filter "Name='Share'").InvokeMethod("Delete",$null)


# 1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.

# Написал два скрипта -для двоичной маски и десятичной - не понял как ввести два параметра сразу - с типом [ipadress] и [int] для маски сети.

# Скрипт №1 -работает с двоичной маской

[CmdletBinding()]

param(

[parameter(Mandatory=$true,HelpMessage="Enter IP1:")]
[ipaddress]$ip1,

[parameter(Mandatory=$true,HelpMessage="Enter IP2:")]
[ipaddress]$ip2,

[parameter(Mandatory=$true,HelpMessage="Enter MASK:")]
[ValidateRange(1,31)]
[Int] $MaskBits
  )

# Переводим битовую маску в десятичную.

  $mask = ([Math]::Pow(2, $MaskBits) - 1) * [Math]::Pow(2, (32 - $MaskBits))
  $bytes = [BitConverter]::GetBytes([UInt32] $mask)
  $NetMask =(($bytes.Count - 1).. 0 | ForEach-Object { [String] $bytes[$_] }) -join "."
  $Netmask = [IPAddress]$Netmask.Trim()
   
# Вычисляем сеть в которой находятся IP-адреса. 

[ipaddress]$NetworkID =($ip1.Address -band $Netmask.Address)
[ipaddress]$NetworkID2 =($ip2.Address -band $Netmask.Address)

# Проводим сравнение и вывод.

if($ip1 -eq $ip2) {
    Write-host -f Red "These Ip-addresses are the same! Enter again!"
    }
elseif ("$NetworkID" -eq "$NetworkID2") {
    Write-host -f Green "These Ip-addresses are in the same network $NetworkID $Netmask!"
    } 
else {
    Write-Host -f Red "These Ip-addresses are not in the same network !"
    }
    

# Скрипт №2 -работает с десятичной маской

[CmdletBinding()]

param(

[parameter(Mandatory=$true,HelpMessage="Enter IP1:")]
[ipaddress]$ip1,

[parameter(Mandatory=$true,HelpMessage="Enter IP2:")]
[ipaddress]$ip2,

[parameter(Mandatory=$true,HelpMessage="Enter MASK:")]
[ValidateScript({Test-IPv4MaskString $_})]
[ipaddress]$NetMask

)

# Определяем, действительна ли строка маски подсети IPv4 (например, "255.255.255.0")

function Test-IPv4MaskString {
 
  param(
    [parameter(Mandatory=$true)]
    [String] $MaskString
  )
  $validBytes = '0|128|192|224|240|248|252|254|255'
  $maskPattern = ('^((({0})\.0\.0\.0)|'      -f $validBytes) +
                 ('(255\.({0})\.0\.0)|'      -f $validBytes) +
                 ('(255\.255\.({0})\.0)|'    -f $validBytes) +
                 ('(255\.255\.255\.({0})))$' -f $validBytes)
  $MaskString -match $maskPattern
}

# Вычисляем сеть в которой находятся IP-адреса. 
 
[ipaddress]$NetworkID =($ip1.Address -band $Netmask.Address)
[ipaddress]$NetworkID2 =($ip2.Address -band $Netmask.Address)

# Проводим сравнение и вывод.

if($ip1 -eq $ip2) {
    Write-host -f Red "These Ip-addresses are the same! Enter again!"
    }
elseif ("$NetworkID" -eq "$NetworkID2") {
    Write-host -f Green "These Ip-addresses are in the same network $NetworkID $NetMask!"
    } 
else {
    Write-Host -f Red "These Ip-addresses are not in the same network !"
    }


# 2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)

Get-command -Module Hyper-V


# 2.2.	Получить список виртуальных машин 

Get-VM


# 2.3.	Получить состояние имеющихся виртуальных машин

Get-VM | Select-Object Name,State,Status


# 2.4.	Выключить виртуальную машину

Stop-VM -Name VM1


# 2.5.	Создать новую виртуальную машину

New-VM -Name "VM4" -MemoryStartupBytes 1GB -NewVHDPath d:\VM4.vhdx -NewVHDSizeBytes 20gb


# 2.6.	Создать динамический жесткий диск

New-VHD -Path d:\Base.vhdx -SizeBytes 10GB


# 2.7.	Удалить созданную виртуальную машину

Remove-VM -Name VM4














    











