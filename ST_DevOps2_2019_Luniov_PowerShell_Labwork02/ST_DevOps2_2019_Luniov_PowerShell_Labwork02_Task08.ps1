# 8. Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp

$TotalLength=0

Get-ChildItem C:\Windows -Recurse -Exclude *.tmp|Where-Object {-not $_.PSiscontainer} |ForEach-Object {$TotalLength+=$_.Length}

Write-Host $TotalLength 
