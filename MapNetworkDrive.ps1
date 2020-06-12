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
# MapNetworkDrive.ps1
# v1.0 190314 Initial creation - Map network drive - DriveName NetworkPath (Username - optional) (Password - optional)
##################################################################################################################
#>

<#
.SYNOPSIS
    Map network drive
.DESCRIPTION
    Create a mapping of a network drive with the current user credentials or with diffrent credentials 
.INPUTS
    DriveName - the drive of the new mapped drive (for example X:)
    NetworkPath - the network path we want the new drive will mapped to (for example '\\Server01\Share1')
    Username - (optional) the username we want to use for the drive mapping (for example Contoso\JohnD). 
    Password - (optional) the username's password.
.EXAMPLE
    MapNetworkDrive 'X:' '\\Server01\Share1'
    MapNetworkDrive 'X:' '\\Server01\Share1' 'contoso\JohnD' 'TheBestPassword!!!'    
#> 
Param (
[parameter(Position=0,mandatory=$true)][String]$DriveName,
[parameter(Position=1,mandatory=$true)][String]$NetworkPath,
[parameter(Position=2,mandatory=$false)][String]$Username,
[parameter(Position=3,mandatory=$false)][String]$Password
)

if($PSBoundParameters.ContainsKey('Username') -and $PSBoundParameters.ContainsKey('Password'))
{
    New-SmbMapping -LocalPath $DriveName -RemotePath $NetworkPath -UserName $Username -Password $Password
}
else
{
    New-SmbMapping -LocalPath $DriveName -RemotePath $NetworkPath -Persistent $true 
}
