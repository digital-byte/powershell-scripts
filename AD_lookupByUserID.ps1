
do {
$resp = Read-Host "Enter User ID:     Or Exit to quit"
Get-ADUser -Filter 'EmployeeNumber -like "$resp"' -Properties * | Format-Table EmployeeNumber,Name,Enabled,EmailAddress -A
#Get-ADUser -Filter 'surname -like "Baker"' -Properties * | Format-Table EmployeeNumber,Name,GivenName,Surname,Enabled,EmailAddress -A
}
until ($resp.ToLower() -eq "exit")
