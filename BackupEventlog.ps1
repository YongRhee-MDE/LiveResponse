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
# BackupEventLog.ps1
# v1.0 190314 Initial creation - Backs up the event logs
##################################################################################################################
#>

<#
.SYNOPSIS
    Export eventlog files from computer and compress the logs.
.DESCRIPTION
    Allows to export specific eventlog file or all eventlog files.
    The exported logs will be compressed.
.OUTPUTS
  path to compress file contains the eventlog files.
#>
BEGIN
{
    $baseDirectory = "C:\WINDOWS\TEMP\" 
    $targetCompressedFilePath = $baseDirectory + $env:computername + "eventlog" + (get-date -f _yyyyMMdd-HHmmss)
}
PROCESS
{
    # Create a temporary folder for the exporated logs
    $output = New-Item -ItemType Directory -Path $targetCompressedFilePath -Force

    # build menu of eventlog files to export
    $index =1;
    $logList=@()
    $logList += New-Object psobject -Property @{LogFileName="All"; Option=$index}
    $index+=1
   
    $logFiles = Get-WmiObject Win32_NTEventlogFile 

    $output = foreach($logFile in $logFiles)
    {
        $exportFileName = $logFile.LogfileName + (get-date -f _yyyyMMdd-HHmmss) + ".evt"            
        $logFile.backupeventlog($targetCompressedFilePath + '\\' + $exportFileName)
    }   

    # compress the temporary folder to compresses file
    Compress-Archive -Path $targetCompressedFilePath -DestinationPath $targetCompressedFilePath -CompressionLevel Optimal
    # remove the temporary folder 
    Remove-Item -Path $targetCompressedFilePath -Recurse        

    Write-Host "compressed eventlog archive saved to:"
    Write-Host "$($targetCompressedFilePath).zip"
}
END {}

