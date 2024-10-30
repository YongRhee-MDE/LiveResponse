#!/bin/bash
# For Linux Servers running Microsoft Defender for Endpoint.
# A bash script to run the aka.ms/xMDEClientAnalyzerBinary on a x64 and ARM64 Linux.
#Download the Microsoft Defender for Endpoint client analyzer
#https://learn.microsoft.com/microsoft-365/security/defender-endpoint/download-client-analyzer
#Run the client analyzer on macOS and Linux
#https://learn.microsoft.com/microsoft-365/security/defender-endpoint/run-analyzer-macos-linux
#Use nano or vim to edit this bash script
#Contributors: Andy Hsu, John Nix, Mina Abdelmalek, Yong Rhee
#version: 241030

#Remove the existing temp folder use to store the xMDEClientAnalyzer data

folder_path="/tmp/mdetemp"

if [ -d "$folder_path" ]; then
  echo "Folder exists. Deleting..."
  rm -r "$folder_path"
else
  echo "Folder does not exist."
fi

#find where mdatp process is
#which mdatp, results in /usr/bin/mdatp

/usr/bin/mdatp connectivity test
echo Done testing MDE on Linux network connectivity

/usr/bin/mdatp log level set --level debug
echo Done setting MDE on Linux in debug mode

#Download the analyzer binary
/usr/bin/curl -s -L "https://aka.ms/XMDEClientAnalyzerBinary" -o "/tmp/XMDEClientAnalyzerBinary.zip"

#Confirm the binary hash from this URL: https://learn.microsoft.com/defender-endpoint/run-analyzer-macos-linux
#Validate the file after the download
echo '2A9BF0A6183831BE43C7BCB7917A40D772D226301B4CDA8EE4F258D00B6E4E97 /tmp/XMDEClientAnalyzerBinary.zip' | sha256sum -c

echo "File downloaded to: /tmp/XMDEClientAnalyzerBinary.zip"

unzip -qq /tmp/XMDEClientAnalyzerBinary.zip -d /tmp/mdetemp
echo A | unzip -qq /tmp/mdetemp/SupportToolLinuxBinary.zip -d /tmp/mdetemp/SupportToolLinuxBinary

#Execute the x MDE Client Analyzer diagnostic command to generate diagnostics data which includes more information from the MDE on Linux endpoint.
echo yes | /tmp/mdetemp/SupportToolLinuxBinary/MDESupportTool -d -o /tmp/mdetemp/mdeclientanalyzerdata
mkdir /tmp/mdetemp/copytemp
/usr/bin/mdatp diagnostic create --path /tmp/mdetemp/copytemp

#Move the guid named zip file to a new location with a known file name to make it easier to use the Live Response API to collect the file when the script is complete.
mv /tmp/mdetemp/copytemp/*.zip /tmp/mdetemp/mde_diagnostics.zip


/usr/bin//mdatp log level set --level info
echo Done setting MDE on Linux back to info mode

#Finished collecting the data
echo "xMDEClientAnalyzer data is available for download:/tmp/mdetemp/mdeclientanalyzerdata.zip"
echo "MDE Diagnostics data is available for download:/tmp/mdetemp/mde_diagnostics.zip"

#Known issue, it currently does not collect:
#definitions.txt
#dlp_health.txt
#dlp_policy_files.zip
#dlp_store_files.zip
#exclusions.txt
#health.txt
#health_details_features.txt
#lsof.txt
#mdatp_config.txt
#mde_bundle_validity.txt
#mde_directories.txt
#mde_event_statistics.txt
#mde_process_sampling.zip
#mde_process_vmmap.zip
#mde_user.txt
#mpenginedb.db
#mpenginedb.db-shm
#mpenginedb.db-wal
#netext_config.txt
#network_info.txt
#permissions.txt
#rtp_statistics.txt
#threat_list.txt
