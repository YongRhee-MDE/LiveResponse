# Unquarantine file and retrieve
# get restoration path.  This is where our malicious file will be restored to
# Feel free to ping @flyingbluemonki on twitter or mattegen@microsoft.com for more information

param
(
    $restorePath = $(throw "-restorePath is a required value!")
)
Set-Location $env:ProgramFiles"\Windows Defender\"
# call mpCmdRun and get a list of restorable files
$restorableFiles = .\mpcmdrun.exe -Restore -listAll
#Safety check.  Are there any quarantined items?
if($restorableFiles -ne "No quarantined items.")
{
    # there are quarantined items. 
    # Create a temporary folder for our file to be zipped into
    md c:\zipTemp -erroraction silentlycontinue
    # Now, let's get our file(s)
    .\mpcmdrun.exe -Restore -All -Path c:\zipTemp
    # Lets make a name for our .zip file
    $fileStamp = get-date -Format MM-dd-yyyy-HHMM
    $fileStamp = $restorePath + "\MaliciousContent_" + $fileStamp + ".zip"
    #Compress the file 
    compress-archive c:\zipTemp -destinationpath $fileStamp -force
    #delete the temprorary zip path
    del c:\zipTemp -recurse
    $hashValue = Get-FileHash -Algorithm SHA1 $fileStamp
    write-host("Created " + $fileStamp + " with signature: " + $hashValue.Hash)
}
else 
{
    write-host("Uh oh.  This machine has no quarantined items")
}