# 6. Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process |Sort-Object TotalProcessorTime | Select-Object ProcessName, TotalProcessorTime -Last 6  

