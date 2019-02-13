# 1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
 
 #Не нашёл подходящего решения - вывожу список числовых значений Windows переменных с помощью скрипта ниже,но не могу докрутить до суммы..
 
$allenv= Get-Childitem env:
$tempenv=0
foreach ($env in $allenv) {
    try {
        $tempenv=[int]($env.value) 
        Write-Host $tempenv
    }
    catch {
        $i++
    }
}

 #вычисление всех переменных сеанса проходит так

Get-Variable | Where-Object {$_.Value -and $_.Value.GetType().Name -eq "Int32"}|Measure-Object -Property Value -Sum 




