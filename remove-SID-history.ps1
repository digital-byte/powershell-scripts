$prompt = Read-Host "Enter 'Yes' to remove a single user SIDHistory
                        OR Proceed with !!!CAUTION!!!
if you are fully aware of the implications to the ACLs, exchange server, domain profiles or 
any other implications that removing the sIDHistory of a user would cause, you may enter
'*' to remove all sIDHistory generated of all users on a domain.

"

If (($prompt -eq "Yes") -or ($prompt -eq "yes") -or ($prompt -eq "y") -or ($prompt -eq "Y")) {
    $user = Read-Host "Username to remove sIDHistory from"
    try { Get-aduser -Identity $user |out-null
        Write-Output "$user exists, continuing"
        } catch {
        Write-Output "$user does NOT exist. Exiting. Please verify user and try again"
        exit}
    try { $domain = Read-Host "Enter the domain you wish to use"
        $remSid = Get-ADUser -filter {name -eq $user} -searchbase "dc=$domain,dc=local" -searchscope subtree -properties sidhistory | foreach {Set-ADUser $_ -remove @{sidhistory=$_.sidhistory.value}}
        } catch {
        Write-Host "The given user: $user does not have an SIDHistory to clearout, verify the user and try again"
        }
    Write-Host "Finished"
    } Elseif ($prompt -eq "*") {
    $prompt2 = Read-Host "Are you sure???"
    If ($prompt2 -eq "Yes") {
        Write-host "Get ready for a lot of work"
        Get-ADUser -filter 'sidhistory -like "*"' -searchbase "dc=$domain,dc=local" -searchscope subtree -properties sidhistory | foreach {Set-ADUser $_ -remove @{sidhistory=$_.sidhistory.value}}
        } Else {
        Write-Host "You didn't remove anything"
        }
    } Else {
    Write-Host "Not a valid input"
    }
