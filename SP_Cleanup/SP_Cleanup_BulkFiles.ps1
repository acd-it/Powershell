
# Based on a specific Site URL and Relevant URL, deletes all versions except latest 50 versions.

# Parameters
$SiteURL = "SP_URL"
$FileRelativeURLs = @(
"SP_FILE_URL"


    # Add more file paths as needed
)

# Connect to PnP Online
Write-Output "Connecting to PnP Online..."
Connect-PnPOnline -Url $SiteURL -Interactive

foreach ($FileRelativeURL in $FileRelativeURLs) {
    try {
        # Get all versions of the File
        Write-Output "Retrieving file versions for: $FileRelativeURL"
        $Versions = Get-PnPFileVersion -Url $FileRelativeURL

        # Check if versions were retrieved
        if ($Versions) {
            Write-Output "File versions retrieved successfully for: $FileRelativeURL"

            # Sort versions by creation date (if needed)
            Write-Output "Sorting file versions by creation date for: $FileRelativeURL"
            $SortedVersions = $Versions | Sort-Object Created -Descending

            # Keep only the last 50 versions
            Write-Output "Selecting the last 50 versions to keep for: $FileRelativeURL"
            $VersionsToKeep = $SortedVersions | Select-Object -First 50
            $VersionsToDelete = $SortedVersions | Where-Object { $_.VersionLabel -notin $VersionsToKeep.VersionLabel }

            # Delete all versions except the last 50
            Write-Output "Deleting old versions, keeping only the last 50 for: $FileRelativeURL"
            foreach ($Version in $VersionsToDelete) {
                Write-Output "Deleting version: $($Version.VersionLabel) for file: $FileRelativeURL"
                Remove-PnPFileVersion -Url $FileRelativeURL -Identity $Version.VersionLabel -Force
            }

            # Execute the changes
            Write-Output "Executing changes for: $FileRelativeURL"
            Invoke-PnPQuery
            Write-Output "Old versions deleted successfully, keeping the last 50 versions for: $FileRelativeURL"
        } else {
            Write-Output "No versions found for the file: $FileRelativeURL"
        }
    }
    catch {
        Write-Error "An error occurred for file: $FileRelativeURL - $_"
    }
}
