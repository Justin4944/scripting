$Listpc=(Get-ADComputer -Filter 'Name -like "DESKTOP*"').name
Foreach ($line in $Listpc)
{
               
$Listuser=(Get-ADUser -Filter * -searchbase "DC=ACME,DC=FR").SamAccountName



    Foreach($user in $Listuser)

{
        New-Item -Path "C:\SAV\$user" -ItemType directory
        xcopy "\\$line\$user\" "\\SRVWIN01\SAV\$user"
}
}
