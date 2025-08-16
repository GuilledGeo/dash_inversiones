# make.ps1 - Alternativa a Makefile para PowerShell
param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$Command
)

$LocalPath = (Get-Location).Path
$ImageName = "churn-api"
$WorkDir = "/app"

switch ($Command.ToLower()) {

    "build" {
        Write-Host "🛠️  Construyendo imagen Docker..."
        docker build -t $ImageName .
    }

    "run" {
        Write-Host "🚀 Lanzando API en http://localhost:8000 ..."
        docker run -v "${LocalPath}:$WorkDir" -w $WorkDir -e PYTHONPATH=$WorkDir -p 8000:8000 $ImageName
    }

    "retrain" {
        Write-Host "🤖 Reentrenando modelo dentro del contenedor..."
        docker run -v "${LocalPath}:$WorkDir" -w $WorkDir -e PYTHONPATH=$WorkDir $ImageName python src/scripts/retrain_and_export.py
    }

    "clean" {
        Write-Host "🧹 Limpiando modelos y cachés..."
        Remove-Item -Recurse -Force outputs/models/*.pkl -ErrorAction SilentlyContinue
        Remove-Item -Recurse -Force __pycache__, .pytest_cache -ErrorAction SilentlyContinue
    }

    default {
        Write-Host "❌ Comando no reconocido. Usa uno de los siguientes:"
        Write-Host "   build   → Construye la imagen Docker"
        Write-Host "   run     → Lanza la API"
        Write-Host "   retrain → Reentrena el modelo"
        Write-Host "   clean   → Elimina modelos y cachés"
    }
}
