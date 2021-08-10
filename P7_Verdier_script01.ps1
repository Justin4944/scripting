

if ( $args[0] -eq "h" )
{
        echo "script nom d'utilisateur login mdp etage service direction"
        exit
}


$nom=$args[0]

if ( $nom -isnot [string] )
{
        $nom=read-host "Merci de rentrer le nom et le prénom de l'utilisateur à créer"
}

$login=$args[1]

if ( $login -isnot [string] )
{
        $login=read-host "Merci de rentrer le login de l'utilisateur à créer"
}

$mdp=$args[2]

if ( $mdp -isnot [string] )
{
        $mdp=read-host "Merci de rentrer le mot de passe de l'utilisateur"
}

$Etage=$args[3]

if ( $Etage -isnot [string] )
{
        $Etage=read-host "Merci d'indiquer l'étage de l'utilisateur"
}

$service=$args[4]

if ( $service -isnot [string] )
{
        $service=read-host "Merci d'indiquer le service"
}

$direction=$args[5]

if ( $direction -isnot [string] )
{
        $direction=read-host "Merci d'indiquer la direction"
}

$groupe=$args[6]

if ( $groupe -isnot [string] )
{
        $groupe=read-host "Merci de Rentrer le Nom du Groupe cible"
}

$dossier=$args[7]

if ( $dossier -isnot [string] )
{
        $dossier=read-host "Merci de rentrer le chemin du dossier"
}
echo "$name", "$login", "$mdp", "$etage", "$service", "$direction", "$groupe", "$dossier"

# Création d'un nouvel utilisateur

write-host "Etage 0 service Accueil, Direction Accueil
            Etage 1 service Direction des Ressources Humaines, Responsable Cadres, Responsable Formation, Responsable Non Cadres, Responsable Paye, Direction Ressources Humaines
            Etage 2 service Direction Technique, Responsable Logistique, Responsable Nouveaux Projets, Responsable Support, direction Technique
            Etage 3 service Direction Financière, Responsable Banques, Responsable Comptabilité, Responsable Support, direction Finance
            Etage 4 service Direction Marketing, Responsable Marketing Dev, Responsable Marketing Opérationnel, Stagiaire Marketing, direction Marketing
            Etage 5 service Assistance Direction, Direction Générale, direction Direction"

try
{
    New-ADUser -Name $nom -SamAccountName $login -UserPrincipalName $login@acme.fr -Path "OU=$service,OU=$direction,OU=$etage,DC=acme,DC=fr" -AccountPassword (ConvertTo-SecureString -AsPlainText $mdp -Force) -PasswordNeverExpires $true -CannotChangePassword $true -Enable $true
    write-host "L'utilisateur $nom a été créé correctement"
}
catch
{
    Write-host "Impossible de créer l'utilisateur de $nom"
}


# Création de dossier pour chaque utilisateur

try
{
    New-item -Path $Dossier -ItemType Directory
    Write-host "Le dossier de $nom a été créé dans le dossier $Dossier"
}
catch
{
    Write-host "Impossible de créer le dossier de $nom dans le dossier $Dossier"
}

#Création du partage de dossier

try
{
    New-SmbShare -Name $nom -Path $Dossier -Fullaccess Administrateurs
        Grant-SmbShareAccess -Name $nom -Accountname $login@acme.fr -AccessRight Full
Write-Host "Le dossier $nom a bien été partagé"
}
catch
{
    Write-host "Impossible de partager le dossier $nom"
}
