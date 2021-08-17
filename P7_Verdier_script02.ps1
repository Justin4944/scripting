# Lister les membres d'un groupe


$groupe=$args[0]

if ( $groupe -isnot [string] )
{
        Get-ADGroup -Filter 'Name -like "ACME*"' | Format-Table Name
        $groupe=read-host "Merci de préciser le groupe que vous voulez voir"
}

$dossier=$args[1]

if ( $dossier -isnot [string] )
{
        $dossier=read-host "Merci d'indiquer le chemin de sauvegarde"
}

try
{
    Get-ADGroupMember -identity $groupe | select-object name | Export-Csv membres.csv -Encoding UTF8
    write-host "Votre fichier a bien été créé"
}
catch
{
    write-host "Impossible d'afficher les membres de ce groupe"
}