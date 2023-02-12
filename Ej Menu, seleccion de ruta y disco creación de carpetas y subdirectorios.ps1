#comprobadores de SO para que el script funcione en ellos.
if ($IsLinux) {
    Write-Host "Estas ejecutando esto en Linux "
}
elseif ($IsWindows) {
    Write-Host "Estas ejecutando esto en Windows "
}
elseif ($IsMacOS) {
    Write-Host "Estas ejecutando esto en Mac, este script no funcionara "
}
function Show-Menu #define la funcion menu para crear posteriormente el menu dentro de un bucle y ahorrar linias de codigo al poderse llamar
{
    param (
        [string]$Title = 'Menu' #define el menu como una string con un titulo. Posteriormente da los datos que se han de escribir
    )
    Clear-Host
    Write-Host "================ Menu ================"
    
    Write-Host "Presiona 1 para crear listar las unidades conectadas, o elegir una ruta"
    Write-Host "Presiona 2 para crear los empresaArt y sus subdirectorios en la ruta o unidad seleccionada"
    Write-Host "Q: Pressiona 'q' para salir."
}


do { #encierra el swicht del menu en do while para que se ejcute hasta que la condicion de salida se cumpla.
    Show-Menu $Title 'Menu'
    $selection = Read-Host "Escoje una opcion"
    switch ($selection)
    {
        '1' { 
            if ($isLinux -or $IsMacOS) {
                do {
                    $Seguir = "0"
                    Clear-Host
                    $Ruta = Read-Host "Tendras que determinar la ruta completa para crear los directorios en otra unidad u particion"
                    if (Test-Path $Ruta) {
                        Write-Host "La ruta es correcta"
                        Write-Host $Ruta
                        Start-Sleep -Seconds 3
                        $Seguir = "N"
                    }
                    if (-not (Test-Path $Ruta)) { #checkea que el directorio escrito por el usuario sea valido
                        $Seguir = Read-Host "¿Volver a intentar? --N-- para salir"
                    }  
                } 
                until ( 
                  $Seguir -contains "N"
                )
            }
            else {
                $drives = Get-PSDrive | Select-Object Root
                Write-Host "Discos disponibles:"
                for ($i = 0; $i -lt $drives.Count; $i++) #bucle incremental para contabilizar y mostrar las unidades seleccionadas
                        {
                        Write-Host "$i $($drives[$i].Root)" #escribe por pantalla cada interacción que hace la variable $i cada vez que se incrementa y encuentra un disco
                        }
                $driveIndex = Read-Host "Selecciona el disco para continuar"
                $Ruta = $drives[$driveIndex].Root #asigna la ruta del disco elegido a la variable Ruta
                Clear-Host
                Write-Host "Tu disco seleccionado es $Ruta"
                Start-Sleep -Seconds 3
                
            }
        } 
        '2' {
            if (Test-Path $Ruta) { #checkea que el directorio escrito por el usuario sea valido si no lo mandara a realizar la opcion 1
            Write-Host "Se crearan las carpetas en el directorio indicado anteriormente"
            New-Item -ItemType Directory -Path $Ruta\empresaMadeArt #crea el directorio madre empresaMadeArt en la Ruta asignada
            New-Item -ItemType Directory -Path $Ruta\empresaMadeArt\Administracion #crea el hijo de la anterior de la carpeta empresaMadeArt
            New-Item -ItemType Directory -Path $Ruta\empresaMadeArt\Ventas
            New-Item -ItemType Directory -Path $Ruta\empresaMadeArt\Contabilidad
            New-Item -ItemType Directory -Path $Ruta\empresaMadeArt\Produccion
            New-Item -ItemType Directory -Path $Ruta\empresaMadeArt\Almacen
            Write-Host "carpetas creadas"
            Get-ChildItem -Path "$Ruta\empresaMadeArt" -Directory -Recurse

            Start-Sleep -Seconds 3
        }
        else {
            Write-Host "ejecuta antes el parametro 1"
            Start-Sleep -Seconds 3

        }
        } 
        'q' {
            return
        }
    }
}
while ($selection -ne 'q') #condicion para finalizar el bucle do while
