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
# Jeff Cook and Yong Rhee
# Get-ExternalIPAddress.ps1
# v1.0 200610 Initial creation - Gets the external ip address
##################################################################################################################
#>

<#
.SYNOPSIS
    Executes nslookup myip.opendns.com. resolver1.opendns.com within an MDATP Live response session
.DESCRIPTION
    Executes nslookup myip.opendns.com. resolver1.opendns.com witin an MDATP Live response session
.INPUTS
    Not applicable
.EXAMPLE
    Within an MDATP Live Response session run the following commands to download the content to the machine
    putfile GetExternalIPaddress.ps1
    run the following command witin the live response session to execute the sript
    run Get-ExternalIPaddress.ps1
#>

Function GetExternalIPAddress
{
    $tmp =Invoke-WebRequest -URI http://myip.dnsomatic.com/ -UseBasicParsing
    $tmp.Content
}

## Run it
GetExternalIPAddress
