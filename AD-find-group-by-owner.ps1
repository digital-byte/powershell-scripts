$input = Read-Host -Prompt "What is the prefix you want to search AD for? A wild card will be applied to the end by default"

Get-ADGroup -filter "Name -like '$input*'" -Properties managedBy |
ForEach-Object { `
$managedBy = $_.managedBy;

#uncomment to look for groups owned by specific person, see example below
#if ($managedBy -eq "CN=JONES,OU=Users,OU=Provisioned,OU=Common,DC=<domain>,DC=com")
if ($managedBy)
{
 $manager = (get-aduser -Identity $managedBy -Properties emailAddress);
 $managerName = $manager.Name;
 $managerEmail = $manager.emailAddress;
}
else
{
 $managerName = 'N/A';
 $managerEmail = 'N/A';
}

Write-Output $_; } |
Select-Object @{n='Group Name';e={$_.Name}}, @{n='Managed By Name';e={$managerName}}, @{n='Managed By Email';e={$managerEmail}} | Tee-Object ./AD-owners-of-$input-$(get-date -f yyyy-MM-dd).txt


$adgroups = Get-ADGroup -Filter "Name -like '$input*'" | sort name

$data = foreach ($adgroup in $adgroups) {
    $members = $adgroup | get-adgroupmember | sort name
    foreach ($member in $members) {
        [PSCustomObject]@{
            Group   = $adgroup.name
            Members = $member
        }
    }
}

$data | export-csv ".\$input-group-membs-$(get-date -f yyyy-MM-dd).csv" -NoTypeInformation
