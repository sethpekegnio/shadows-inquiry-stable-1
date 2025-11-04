# SHADOWS OF INQUIRY - STRUCTURE CORRIGÉE ET OPTIMISÉE

## 🎮 PROJET RÉPARÉ - 1er Novembre 2025

### ✅ CORRECTIONS APPLIQUÉES

#### 1. **InventoryUI.gd - CORRIGÉ**
**Problème**: Utilisation de propriétés inexistantes `border_width_all` et `corner_radius_all`
**Solution**: Remplacement par les méthodes correctes `set_border_width_all()` et `set_corner_radius_all()`

```gdscript
# ❌ ANCIEN (ERREUR)
style_box.border_width_all = 2
style_box.corner_radius_all = 5

# ✅ NOUVEAU (CORRECT)
style_box.set_border_width_all(2)
style_box.set_corner_radius_all(5)
```

#### 2. **Inventory.gd - CORRIGÉ**
**Problème**: Syntaxe invalide `class_name InventoryItem:` avec deux-points
**Solution**: Suppression de la classe interne non nécessaire, remplacée par des commentaires explicatifs

```gdscript
# ❌ ANCIEN (ERREUR)
class_name InventoryItem:
    var id: String
    var name: String

# ✅ NOUVEAU (CORRECT)
# Structure pour un item d'inventaire
# Les items sont stockés comme Dictionary avec les clés:
# - id: String
# - name: String
# - icon: Texture2D
# - actions: Array[String]
# - data: Dictionary
```

### 📂 STRUCTURE DU PROJET

```
shadows-inquiry/
├── 📁 scenes/              # Toutes les scènes (.tscn)
│   ├── 📁 menus/          # Menus du jeu
│   ├── 📁 locations/      # Lieux (Appartement, Commissariat, etc.)
│   └── 📁 ui/             # Interfaces utilisateur
│
├── 📁 scripts/            # Scripts GDScript (.gd)
│   ├── Global.gd         # Singleton - Données globales
│   ├── Inventory.gd      # Singleton - Système d'inventaire
│   ├── SaveManager.gd    # Gestion des sauvegardes
│   └── ...
│
├── 📁 assets/            # Ressources visuelles et audio
│   ├── 📁 audio/         # Musiques et sons
│   ├── 📁 images/        # Images et textures
│   └── 📁 character/     # Ressources personnage
│
├── 📁 addons/            # Plugins Godot (vide pour l'instant)
│
└── 📄 project.godot     # Configuration du projet

```

### 🎯 FICHIERS PRINCIPAUX

#### **AUTOLOAD (Singletons)**
- `Global.gd` → Données joueur, stats, progression
- `Inventory.gd` → Système d'inventaire (10 slots)

#### **SCÈNES PRINCIPALES**
1. **MainMenu.tscn** → Menu principal (point d'entrée)
2. **CharacterCreation.tscn** → Création de personnage
3. **Appartement3D.tscn** → Appartement 3D du joueur
4. **SalleDeBain.tscn** → Salle de bain (miroir)
5. **Commissariat.tscn** → Scène du commissariat
6. **CommissariatHub.tscn** → Hub central du commissariat

#### **UI (Interface)**
- **InventoryUI.tscn** → Interface inventaire (10 slots)
- **PauseMenu.tscn** → Menu pause (Échap)
- **OptionsMenu.tscn** → Options du jeu

### 🔧 FONCTIONNALITÉS OPÉRATIONNELLES

✅ **Système de sauvegarde** - Auto-save toutes les 30 secondes
✅ **Système d'inventaire** - 10 slots avec raccourcis 1-0
✅ **Système de progression** - Suivi des étapes du jeu
✅ **Création de personnage** - Personnalisation complète
✅ **Menu principal** - Navigation fonctionnelle
✅ **Menu pause** - Touche Échap

### 🎮 CONTRÔLES

- **ZQSD** → Déplacement
- **E** → Interagir
- **1-0** → Sélection rapide inventaire
- **Échap** → Menu pause
- **Tab** → Inventaire (si implémenté dans la scène)

### 📊 SYSTÈME DE STATS (Cachées)

Le joueur possède 10 stats cachées qui évoluent selon ses actions :

1. **Violence** (0-10) - Force physique, combat
2. **Empathie** (0-10) - Persuasion, compréhension
3. **Intuition** (0-10) - Détection d'indices
4. **Résilience** (0-10) - Survie, résistance
5. **Alliés** (0-10) - Réseau de contacts
6. **Corruption** (0-10) - Niveau de corruption
7. **Santé Mentale** (0-10) - État psychologique
8. **Réputation** (0-10) - Image publique
9. **Ressources** (0-10) - Argent, équipement
10. **Karma** (-10 à +10) - Moralité

### 🎲 SYSTÈME PUNITIF

Le jeu inclut un système de **mort permanente et runs multiples** :

- ⚠️ **Caméras de surveillance** → Mort si détecté
- ⚠️ **Assassins** → Combat ou fuite
- ⚠️ **Conséquences permanentes** → Choix qui suivent le joueur
- 🔁 **Runs multiples** → Chaque partie garde des échos de la précédente

### 🚀 POUR LANCER LE JEU

1. Ouvrir le projet dans **Godot 4.5**
2. Vérifier que la scène principale est **MainMenu.tscn**
3. Appuyer sur **F5** ou cliquer sur ▶️ Play
4. Le jeu démarre au menu principal

### 🐛 DÉBOGAGE

Si une erreur persiste :

1. **Ouvrir la console Godot** (en bas de l'éditeur)
2. **Chercher les messages d'erreur** en rouge
3. **Double-cliquer sur l'erreur** → Ouvre le fichier à la ligne problématique
4. **Vérifier les chemins des scènes** dans project.godot

### 📝 ÉTAT DU PROJET

#### ✅ FONCTIONNEL
- Système de sauvegarde
- Menu principal
- Création de personnage
- Système d'inventaire
- Stats et progression
- Menu pause

#### 🔄 EN DÉVELOPPEMENT
- Scènes 3D complètes (Appartement, Commissariat)
- Système de dialogue
- Système de combat
- Enquêtes et investigations
- Système punitif complet

#### 📋 À FAIRE
- Sons et musiques additionnels
- Modèles 3D de personnages
- Animations
- Plus de lieux
- Système de mort/respawn
- Échos entre runs

### 💡 NOTES IMPORTANTES

1. **Ne PAS modifier project.godot manuellement** → Utiliser l'éditeur Godot
2. **Toujours tester après une modification** → F5 dans Godot
3. **Les sauvegardes sont dans** `user://sauvegarde_unique.json`
4. **Les logs s'affichent dans** la console Godot (onglet "Output")

### 🔍 DÉPANNAGE RAPIDE

**"Parse Error: Unrecognized file type"**
→ Vérifier que tous les fichiers .tres et .tscn sont valides

**"Invalid assignment"**
→ Vérifier la syntaxe GDScript (pas de `:` après class_name)

**"Property not found"**
→ Utiliser les méthodes avec `set_` pour StyleBoxFlat

**Le jeu ne démarre pas**
→ Vérifier que run/main_scene="res://MainMenu.tscn" dans project.godot

---

## ✨ PROJET PRÊT À L'EMPLOI

Toutes les erreurs critiques ont été corrigées.
Le jeu devrait maintenant démarrer sans problème ! 🎉

**Date de correction** : 1er Novembre 2025
**Version Godot** : 4.5
**Statut** : ✅ OPÉRATIONNEL
