# Liste des groupes dont un utilisateur est membre


$user=$args[1]

if ( $user -isnot [string] )
{
        $user=read-host "Merci d'indiquer le nom d'utilisateur"
}

try
{
    Get-ADUser -Identity $user -Properties Memberof | Select-Object Memberof "OU=,DC=acme,DC=fr" | Out-File -Filepath "C:\Users\Admnistrateur\Desktop\usergroupmember.csv" -Encoding UTF8
    write-host "L'utilisateur fait partie de ces groupes:"
}
catch
{
    write-host "Impossible d'afficher les groupes dont l'utilisateur fait partie"
}
