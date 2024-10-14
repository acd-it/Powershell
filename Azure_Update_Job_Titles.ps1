
## ACD - 
## Update User Job Titles AzureAD Script ##
## This script takes a CSV file with two columns, email and job title
## It iterates through each, setting the user's job title as it goes.

# Import the CSV file
$users = Import-Csv -Path "path_TO_csv"

# Loop through each row in the CSV
foreach ($user in $users) {
    # Extract the email and job title from the current row
    $email = $user.Email
    $jobTitle = $user.'Job Title'

    # Run the Set-AzureADUser command with the email and job title
    Set-AzureADUser -ObjectId $email -JobTitle $jobTitle

# Echo the result
    Write-Host "Updated user: $email with job title: $jobTitle"
}

