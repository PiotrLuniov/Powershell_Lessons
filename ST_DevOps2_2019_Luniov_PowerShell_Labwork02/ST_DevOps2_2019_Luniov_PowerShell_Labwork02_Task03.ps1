# 3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.

New-Item -ItemType directory -Path "C:\" -Name "M2T2_Luniov"
New-PSDrive -Name "Surname" -PSProvider FileSystem -Root "C:\M2T2_Luniov" 


