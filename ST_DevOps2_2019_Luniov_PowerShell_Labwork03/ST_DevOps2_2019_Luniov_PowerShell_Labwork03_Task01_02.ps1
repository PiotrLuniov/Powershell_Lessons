# 1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
 
 #Не нашёл подходящего решения - Get-ChildItem env: - позволяет получить список Windows переменных,но получить их значение уже не удается..
 #вычисление всех переменных сеанса проходит так

Get-Variable | Where-Object {$_.Value -and $_.Value.GetType().Name -eq "Int32"}|Measure-Object -Property Value -Sum 

