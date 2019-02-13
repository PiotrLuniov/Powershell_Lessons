# 1.3.1 Организовать запуск скрипта каждые 10 минут

# Как необязательный параметр указываем путь к файлу, запускающемуся по расписанию - по умолчанию запускается скрипт из родительской папки.

Param (
        [string]$File=".\ST_DevOps2_2019_Luniov_PowerShell_Labwork03_Task01_03.ps1"
      )

$t= New-JobTrigger -Once -At 4:30PM -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration (New-TimeSpan -Days 1)
$cred = Get-Credential corp\lunev
$o = New-ScheduledJobOption -RunElevated
Register-ScheduledJob -Name Start -FilePath $File -Trigger $t -Credential $cred -ScheduledJobOption $o
