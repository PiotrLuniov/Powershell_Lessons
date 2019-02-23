#1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. Результат представить в виде файла XML.

Get-EventLog -LogName System -EntryType Error | where {$_.TimeGenerated.Date -ge (Get-Date).Adddays(-7).Date} | Export-Clixml -Path c:\errors.xml
