# Liste des groupes dont un utilisateur est membre


$user=$args[0]

if ( $user -isnot [string] )
{
        $user=read-host "Merci d'indiquer le nom d'utilisateur"
}

try
{
    Get-ADUser -Identity $user -Properties Memberof | Select-Object Name, Memberof | Out-File membre.txt
    write-host "L'utilisateur fait partie de ces groupes:"
}
catch
{
    write-host "Impossible d'afficher les groupes dont l'utilisateur fait partie"
}
