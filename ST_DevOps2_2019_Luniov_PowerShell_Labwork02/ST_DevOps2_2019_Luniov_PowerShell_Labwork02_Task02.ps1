# 2. Создать, переименовать, удалить каталог на локальном диске

New-Item -ItemType directory -Path "C:\" -Name "2222"
Rename-Item -Path "C:\2222" -NewName "1111"
Remove-Item -Path "C:\1111" 
