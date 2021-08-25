$Listpc=Get-ADComputer -Filter 'Name -like "DESKTOP*"'
$Listuser=Get-ADUser -Filter { Enabled -eq $true }

Foreach($pc in $Listpc)
{
Foreach($user in $Listuser)
{
    copy-item -Path "\\DNSHostName\C:\Users\$Listuser\Documents -Destination" '\\SRVWIN01\SAV'
}
}