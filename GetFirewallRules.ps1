<##Disclaimer
The sample scripts are not supported under any Microsoft standard support program or service. 
The sample scripts are provided AS IS without warranty of any kind. 
Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. 
The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. 
In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever 
(including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) 
arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
##>

<#
##################################################################################################################
# Microsoft MDATP CxE
# 
# GetFirewallRules.ps1
# v1.0 190314 Initial creation - Gets the Windows Firewall Rules
##################################################################################################################
#>

<#
.SYNOPSIS
    Export firewall rules to csv file.
.DESCRIPTION
    convert machine's firewall rules to csv file and export resuts to file.
.OUTPUTS
  path to firewall rules csv file.
#>
BEGIN
{
    $baseDirectory = "C:\WINDOWS\TEMP\" 
    $targetCsvFilePath = $baseDirectory + $env:computername + "_FirewallRules" + (get-date -f _yyyyMMdd-HHmmss)+".csv"
}
PROCESS
{
    
    Get-NetFirewallRule | Export-Csv $targetCsvFilePath
    write-host "successfully export rules to csv file:" 
    write-host $targetCsvFilePath
}