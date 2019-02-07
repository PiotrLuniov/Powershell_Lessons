# 7. Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.

Get-Process | ForEach-Object{ 
if ($_.VM/1mb -gt 100) {
Write-Host -f Red $_.ProcessName - $($_.VM/1mb)}
else {
Write-Host -f Green $_.ProcessName - $($_.VM/1mb)}
} 
