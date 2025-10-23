# create_structure.ps1
$projectRoot = "."

# Массив всех путей для создания
$paths = @(
    "lib/app/theme",
    "lib/features/characters/data/datasources",
    "lib/features/characters/data/models", 
    "lib/features/characters/data/repositories",
    "lib/features/characters/domain/entities",
    "lib/features/characters/domain/repositories",
    "lib/features/characters/domain/usecases",
    "lib/features/characters/presentation/blocs",
    "lib/features/characters/presentation/pages",
    "lib/features/characters/presentation/widgets",
    "lib/features/favorites/data",
    "lib/features/favorites/domain", 
    "lib/features/favorites/presentation",
    "lib/core/database",
    "lib/core/network",
    "lib/core/utils",
    "lib/shared/widgets"
)

# Создаем все папки
foreach ($path in $paths) {
    $fullPath = Join-Path $projectRoot $path
    if (!(Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force
        Write-Host "Created: $fullPath" -ForegroundColor Green
    }
}

# Создаем основные файлы
$files = @{
    "lib/app/app.dart" = "// App entry point"
    "lib/app/theme/app_theme.dart" = "// Theme configuration"
    "lib/features/characters/domain/repositories/character_repository.dart" = "// Character repository interface"
    "lib/features/characters/data/repositories/character_repository_impl.dart" = "// Character repository implementation"
    "lib/features/characters/domain/entities/character_entity.dart" = "// Character entity"
    "lib/features/characters/data/models/character_model.dart" = "// Character model"
    "lib/features/characters/domain/usecases/get_characters.dart" = "// Get characters use case"
    "lib/features/characters/presentation/blocs/character_bloc.dart" = "// Character BLoC"
    "lib/features/characters/presentation/pages/characters_page.dart" = "// Characters page"
    "lib/core/network/api_client.dart" = "// API client"
    "lib/core/database/local_database.dart" = "// Local database"
    "lib/main.dart" = "// Main application file"
}

foreach ($file in $files.GetEnumerator()) {
    if (!(Test-Path $file.Key)) {
        New-Item -ItemType File -Path $file.Key -Force
        Add-Content -Path $file.Key -Value $file.Value
        Write-Host "Created: $($file.Key)" -ForegroundColor Blue
    }
}

Write-Host "`nProject structure created successfully!" -ForegroundColor Yellow