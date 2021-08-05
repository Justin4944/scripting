$nom = Read-host "Merci de rentrer le nom et le pr�nom de l'utilisateur � cr�er"
$login = Read-host "Merci de rentrer le login de l'utilisateur � cr�er"
$mdp = Read-host "Merci de rentrer le mot de passe de l'utilisateur � cr�er"
$etage = Read-host "Merci d'indiquer l'�tage"
$service = Read-host "Merci d'indiquer le service"
$direction = Read-host "Merci d'indiquer la direction"
$groupe = Read-Host "Merci de Rentrer le Nom du Groupe cible"
$Dossier = read-host "Merci de rentrer le chemin du dossier"

if ( $args[0] -eq "h" )
{
        echo "script nom age"
        exit
}


$nom=$args[0]

if ( $nom -isnot [string] )
{
        $nom=read-host "Quel est votre nom?"
}
$age=$args[1]

if ( $age -isnot [int] )
{
        $age=read-host "Quel est votre age?"
}
echo "Hello $name", "vous avez $age ans"

# Cr�ation d'un nouvel utilisateur

try
{
    New-ADUser -Name $nom -SamAccountName $login -UserPrincipalName $login@acme.fr -Path "OU=$service,OU=$direction,OU=$etage,DC=acme,DC=fr" -AccountPassword (ConvertTo-SecureString -AsPlainText $mdp -Force) -PasswordNeverExpires $true -CannotChangePassword $true -Enable $true
    write-host "L'utilisateur $nom a �t� cr�� correctement"
}
catch
{
    Write-host "Impossible de cr�er l'utilisateur de $nom"
}


# Cr�ation de dossier pour chaque utilisateur

try
{
    New-item -Path $Dossier -ItemType Directory
    Write-host "Le dossier de $nom a �t� cr�� dans le dossier $Dossier"
}
catch
{
    Write-host "Impossible de cr�er le dossier de $nom dans le dossier $Dossier"
}

#Cr�ation du partage de dossier

try
{
    New-SmbShare -Name $nom -Path $Dossier -Fullaccess Administrateurs
        Grant-SmbShareAccess -Name $nom -Accountname $login@acme.fr -AccessRight Full
Write-Host "Le dossier $nom a bien �t� partag�"
}
catch
{
    Write-host "Impossible de partager le dossier $nom"
}
