#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.

[int]$t = $null
Test-Connection "192.168.0.233" | foreach {$t += $_.ResponseTime}
Write-Host "Ping time: $t ms"