# Import IISAdministration module (if necessary)
Import-Module WebAdministration

# Define the name of the IIS website and backup location
$websiteName = "eot"
$websitePath = "C:/inetpub/wwwroot/publish"
$backupPath = "C:/inetpub/wwwroot/backup/$websiteName"
 
# Create a timestamp for the backup folder
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$backupFolder = "$backupPath-$timestamp"

# Step 1: Stop the IIS website
Write-Host "Stopping IIS website: $websiteName"
Stop-WebSite -Name $websiteName

# Step 2: Backup current website files
Write-Host "Backing up current website files to: $backupFolder"
New-Item -Path $backupFolder -ItemType Directory -Force
Copy-Item -Path "$websitePath/*" -Destination $backupFolder -Recurse -Force

# Step 3: Deploy new files
Write-Host "Deploying new application files..."
Copy-Item -Path "C:/path/to/temp/*" -Destination $websitePath -Recurse -Force

# Step 4: Start the IIS website
Write-Host "Starting IIS website: $websiteName"
Start-WebSite -Name $websiteName

# Step 5: Confirm that the website is running
$siteStatus = Get-WebSite -Name $websiteName
Write-Host "Website Status: $($siteStatus.state)"
