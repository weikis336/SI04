Write-Host "creador de usuarios "
$user = Read-Host "Escribe el nombre de la cuenta de usuario"
$contraseña = Read-Host "Escribe la pass de la cuenta de usuario" -AsSecureString
$fullname = Read-Host "Escribe el nombre completo de la cuenta de usuario"
$description = Read-Host "Describe la cuenta de usuario"
New-LocalUser "$user" -Password $contraseña –Fullname "$fullname" -Description "$description"

