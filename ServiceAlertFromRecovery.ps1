#-------------------------------------------------------------------------
# $ServiceName MUST be what is displayed in the Name column when performing
# a "Get-Service." You can find a list of services by doing either a 
# "Get-Service" which gives a full list or something like "Get-Service *something*"
# to reduce your choices.
#
# Once you get the service you want to alert on the "Name" is used in the
# first argument of the script <script>.ps1 ARG0
#
# The second argument (ARG1) is given by the service recovery tab variable
# of %1%.
#
# To setup the alert inside of the Recovery Tab of a service use the following.
# 1. Set an Attempt to "Run Program"
# 2. In Run Program, Program field place
#     C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
# 3. In Command Line Parameters field place
#     -command "& {C:\AdminScripts\ServiceAlertFromRecovery.ps1 '<service name>' %1%}"
#-------------------------------------------------------------------------
$ComputerName = (get-wmiobject Win32_Computersystem).name
$ServiceName = $args[0]
$ServiceDisplayName = (Get-Service $ServiceName).DisplayName
$TimesRestarted = $args[1]

Get-Service $ServiceName
$Status = (Get-Service $ServiceName).Status
If ($Status -ne "Running")
{
	Start-Service $ServiceName
}

function SendAlert
{
  $FromAddress = "ServiceFailure@domain.com"
  $ToAddress = "emailaddr@domain.com"
  $MessageSubject = "Service Failure for $ComputerName"
  $MessageBody = "The $ServiceDisplayName ($ServiceName) service on $ComputerName has restarted $TimesRestarted times in the last 24 hours. Please review server event logs for further information."
  $SendingServer = "<IP ADDR>"

  ###Create the mail message and add the statistics text file as an attachment
  $SMTPMessage = New-Object System.Net.Mail.MailMessage $FromAddress, $ToAddress, $MessageSubject, $MessageBody

  ###Send the message
  $SMTPClient = New-Object System.Net.Mail.SMTPClient $SendingServer
  $SMTPClient.Send($SMTPMessage)
}

SendAlert