## ACD - 
## Clear Calendar Events for AzureAD User ##
## This script clears all calendar events for AzureAD users. 


Remove-CalendarEvents –Identity "$USER_EMAIL" -CancelOrganizedMeetings -QueryStartDate (Get-Date) -QueryWindowInDays 365 -PreviewOnly

# Replace email with the email of the user you want to clear calendar for.

# PreviewOnly is set to true, so no events will be deleted. Remove -PreviewOnly to delete events.

