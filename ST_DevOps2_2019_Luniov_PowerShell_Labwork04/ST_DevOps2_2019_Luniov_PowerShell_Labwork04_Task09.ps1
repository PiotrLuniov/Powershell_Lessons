# 9.	Выводить сообщение при каждом запуске приложения MS Word.

Register-WmiEvent -query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='winword.exe'" -sourceIdentifier "ProcessStarted2" -Action { Write "Word is Running!" }
