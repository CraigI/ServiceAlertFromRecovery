Restarting Serice from Recovery tab using PowerShell script
=================
PowerShell Script that provides a way to monitor and alert on Windows services when they fail.


Please see: http://it-erate.com/restart-windows-service-failure-powershell-script/ for further details on how to configure this script.


Main Files
=================
ServiceAlertFromRecovery.ps1 - Only file needed.


Usage
==================
Use Windows Services Properties and define first, second and subsequent failures. Using the "Run a Program" option for one of the defined failures you can then fill in the "Program" and "Command line parameters" with the following information.

Run Program:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

Command line parameters:
-command "& {C:\AdminScripts\ServiceAlertFromRecovery.ps1 'ServiceName' %1%}"

ServiceName = found on the General tab "Service Name" or using Get-Service
%1% = The count of how many times the service has restarted in a defined period.


About Us
=================
Please stop by and see other things we have going on at IT-erate.com. We hope that you found this script helpful and if so please stop by and
let us know!