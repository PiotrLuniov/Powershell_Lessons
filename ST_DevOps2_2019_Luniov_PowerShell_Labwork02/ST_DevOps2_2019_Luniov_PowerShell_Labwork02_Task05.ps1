# 5. Просуммировать все числовые значения переменных текущего сеанса.

Get-Variable | Where-Object {$_.Value -and $_.Value.GetType().Name -eq "Int32"}| Measure-Object -Property Value -Sum 

