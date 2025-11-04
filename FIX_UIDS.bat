@echo off
echo ===================================
echo FIX GODOT UIDS - Shadows Inquiry
echo ===================================
echo.

REM Change to project directory
cd /d "%~dp0"

echo Étape 1: Suppression du cache UID...
if exist ".godot\uid_cache.bin" (
    del /f ".godot\uid_cache.bin"
    echo   ✓ uid_cache.bin supprimé
) else (
    echo   ⚠ uid_cache.bin n'existe pas
)

echo.
echo Étape 2: Suppression du cache filesystem...
if exist ".godot\editor\filesystem_cache10" (
    del /f ".godot\editor\filesystem_cache10"
    echo   ✓ filesystem_cache10 supprimé
) else (
    echo   ⚠ filesystem_cache10 n'existe pas
)

echo.
echo Étape 3: Suppression global_script_class_cache...
if exist ".godot\global_script_class_cache.cfg" (
    del /f ".godot\global_script_class_cache.cfg"
    echo   ✓ global_script_class_cache.cfg supprimé
) else (
    echo   ⚠ global_script_class_cache.cfg n'existe pas
)

echo.
echo ===================================
echo ✓ NETTOYAGE TERMINÉ !
echo ===================================
echo.
echo INSTRUCTIONS :
echo 1. Fermez Godot complètement si ouvert
echo 2. Rouvrez le projet dans Godot
echo 3. Godot va recréer les caches automatiquement
echo 4. Attendez la fin de l'importation
echo 5. Lancez le jeu (F5)
echo.
pause
