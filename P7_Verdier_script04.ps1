$PC=Get-ADComputer -Filter 'Name -like "DESKTOP*"'

$Users=Get-ADUser -Filter {(ObjectClass -eq "user")}

$Dossier=$PC\C:\$Users