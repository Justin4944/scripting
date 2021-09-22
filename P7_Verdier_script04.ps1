
$Listpc=(Get-ADComputer -Filter 'Name -like "DESKTOP*"').name
Foreach ($line in $Listpc)
{
               
    $Listuser=(Get-ADUser -Filter * -searchbase "DC=ACME,DC=FR").SamAccountName
    

    Foreach($user in $Listuser)

{   

        copy-item -Path "\\$line\Users\$user\Documents" -Destination "C:\SAV\$line\$user\Documents" -Force -Recurse       
}
}
  
   
 # xcopy "\\$line\Users\$user" "C:\SAV\$line\$user" /e   
 # New-Item -Path "C:\SAV\$line\$user" -ItemType directory