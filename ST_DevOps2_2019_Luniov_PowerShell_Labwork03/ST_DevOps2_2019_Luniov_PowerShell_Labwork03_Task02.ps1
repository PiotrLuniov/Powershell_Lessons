#2.	Работа с профилем

#2.1.	Создать профиль
 New-Item -ItemType File -Path $profile -Force

# Начинаем редактирование созданного файла-профиля.

#2.2.	В профиле изменить цвета в консоли PowerShell
 (Get-Host).UI.RawUI.ForegroundColor = "Red"
 (Get-Host).UI.RawUI.BackgroundColor = "Black"

#2.3.	Создать несколько собственных алиасов
Set-Alias -Name "WMI" -Value Get-WmiObject
Set-Alias -Name "Gprocess" -Value Get-Process

#2.4.	Создать несколько констант
$systemprocess = Get-Process -Name System
$diskC = Get-ChildItem -Path C:\

#2.5.	Изменить текущую папку
Set-Location C:\

#2.6.	Вывести приветствие
Write-Host "Hello, buddy!"

#2.7.	Проверить применение профиля

# Проверено - работает!
