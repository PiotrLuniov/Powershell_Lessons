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










    










