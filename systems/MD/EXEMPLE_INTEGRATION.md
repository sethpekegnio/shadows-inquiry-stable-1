# EXEMPLE D'INTÉGRATION AUTOMATIQUE DU MENU PAUSE

## Option 1 : Intégration manuelle dans Godot (RECOMMANDÉ)

1. Ouvrez votre scène (ex: Appartement3D.tscn)
2. Clic droit sur le nœud racine "Appartement3D"
3. Sélectionnez "Instancier une scène enfant"
4. Naviguez vers `PauseMenu.tscn`
5. Cliquez "Ouvrir"
6. Sauvegardez la scène (Ctrl+S)

C'est tout ! Le menu pause fonctionnera avec Échap.

---

## Option 2 : Intégration par script (Avancé)

Si vous voulez ajouter le menu pause automatiquement via code, ajoutez ceci dans le script de votre scène (ex: Appartement3D.gd) :

```gdscript
extends Node3D

# Dans la fonction _ready()
func _ready():
    # Vos autres initialisations...
    
    # Ajouter le menu pause si pas déjà présent
    if not has_node("PauseMenu"):
        var pause_menu = preload("res://PauseMenu.tscn").instantiate()
        add_child(pause_menu)
        print("Menu pause ajouté automatiquement")
```

---

## Vérification que tout fonctionne :

### Test de l'inventaire :

1. Lancez le jeu (F5)
2. L'inventaire doit apparaître **en haut de l'écran**
3. Les 10 cases doivent être visibles avec les numéros [1] à [0]
4. Appuyez sur les touches 1-9-0 : les cases doivent s'illuminer en doré

### Test du menu pause :
1. En jeu, appuyez sur **Échap**
2. Le menu pause doit apparaître avec fond sombre
3. Le jeu doit être figé (plus de mouvement)
4. Les boutons doivent être cliquables :
   - "Reprendre" → Ferme le menu et reprend le jeu
   - "Options" → Affiche un message dans la console
   - "Quitter" → Affiche un message (action à personnaliser)
5. Appuyez sur **Échap** à nouveau → Le menu se ferme

---

## Résolution de problèmes :

### L'inventaire ne s'affiche pas :
- Vérifiez que `InventoryUI` est instancié dans votre scène
- Vérifiez que le nœud `Inventory` (singleton) est bien configuré dans Project Settings → Autoload

### Le menu pause ne fonctionne pas :
- Vérifiez que `ui_cancel` est mappé sur Échap dans Project Settings → Input Map
- Assurez-vous que PauseMenu.tscn est bien instancié dans votre scène
- Regardez la console (Output) pour les messages "PAUSE MENU READY"

### Le jeu ne se met pas en pause :
- Vérifiez que les nœuds qui doivent être pausés ont `process_mode = PROCESS_MODE_INHERIT` (par défaut)
- Les nœuds avec `PROCESS_MODE_ALWAYS` continueront à fonctionner (c'est normal pour l'UI)

### Les touches 1-0 ne fonctionnent pas :
- Testez d'abord si l'inventaire est visible
- Vérifiez la console pour le message "INVENTORY UI READY"
- Les touches numériques du pavé numérique ne fonctionnent pas, utilisez celles au-dessus des lettres

---

## Structure finale de votre scène :

```
Appartement3D (Node3D)
├── Camera3D
├── DirectionalLight3D
├── Player (CharacterBody3D)
├── [... vos autres nœuds ...]
├── CanvasLayer
│   └── [... vos labels ...]
├── InventoryUI (CanvasLayer) [Déjà présent normalement]
└── PauseMenu (CanvasLayer) [À AJOUTER]
```

---

## Personnalisation avancée :

### Changer la touche de pause :
1. Project Settings → Input Map
2. Trouvez `ui_cancel`
3. Changez la touche (par défaut Échap)

### Ajouter des effets au menu pause :
Dans `PauseMenu.gd`, fonction `pause_game()` :
```gdscript
func pause_game():
    get_tree().paused = true
    show()
    # Ajoutez ici vos effets :
    # - Animation d'apparition
    # - Son de pause
    # - Effet de flou sur le jeu
    print("Jeu mis en pause")
```

### Sauvegarder avant de quitter :
Dans `_on_quit_button_pressed()` :
```gdscript
func _on_quit_button_pressed():
    # Sauvegarder avant de quitter
    if SaveManager:
        SaveManager.save_game()
    
    resume_game()
    get_tree().change_scene_to_file("res://MainMenu.tscn")
```

---

## 📝 Checklist finale :

- [ ] PauseMenu.tscn est instancié dans la scène de jeu
- [ ] L'inventaire est visible en haut de l'écran
- [ ] Échap ouvre le menu pause
- [ ] Le jeu se fige pendant la pause
- [ ] Les touches 1-0 sélectionnent les slots d'inventaire
- [ ] Le slot sélectionné s'illumine en doré
- [ ] Les boutons du menu pause sont fonctionnels

Tout est prêt ! 🎮
