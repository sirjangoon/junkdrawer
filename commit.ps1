# Description
# you can use this to create a backup of a file with date and time appended to its name.
# The backup file will save to $Folder
# You can also include a message
# This message will update $Tracker file with your message as a way to track your changes

# Example
# .\commit.ps1 -File "My thesis.pdf" -Message "Updated Introduction"

# .\commit.ps1 -File "My thesis.pdf" -Message "Updated Introduction" -Folder "backup" -Tracker "changelog.txt"


param (
    # this is your master file
    [string]$File,

    # this is the folder where you will save dated copies to
    [string]$Folder = "backup",

    # this is your tracker/commit file for tracking commits
    [string]$Tracker = "changelog.txt",

    # this is your message you can include for each commit
    [string]$Message
)

$saveFolder = Join-Path -Path ".\" -ChildPath $Folder
$filePath = Join-Path -Path ".\" -ChildPath $File
$trackerPath = Join-Path -Path ".\" -ChildPath $Tracker

if (-not (Test-Path $saveFolder)) {
    New-Item -Path $saveFolder -ItemType directory | Out-Null
}

if (-not (Test-Path $filePath)) {
    Write-Host "This file does not exist: $filepath"
}

$baseName = (Get-Item $filePath).BaseName
$extName = (Get-Item $filePath).Extension

$versionedFilePath = Join-Path -Path $saveFolder -ChildPath "$baseName $(Get-Date -format "yyyy-MM-dd HHmm")$extName"
Copy-Item $filePath -Destination $versionedFilePath

Add-Content -Path $trackerPath $(Get-Date -Format "dddd yyyy-MM-dd HH:mm")
Add-Content -Path $trackerPath "$Message`n"
