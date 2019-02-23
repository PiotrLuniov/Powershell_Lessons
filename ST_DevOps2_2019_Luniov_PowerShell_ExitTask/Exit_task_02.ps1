﻿# 2.	Вывести список файлов *.log хранящихся в папке C:\Windows. Вывод организовать в виде таблицы с обратной сортировкой по имени файла, при этом выводить полное имя файла, размер файла, время создания. 
Get-ChildItem c:\windows\*.log  | Sort-Object Name -Descending |Format-Table FullName, Length, CreationTime -AutoSize 
