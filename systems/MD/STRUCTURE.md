# 📁 STRUCTURE COMPLÈTE DU PROJET

## 🎮 SCÈNES (.tscn)
```
MainMenu.tscn          → Menu principal (scène de démarrage)
SalleDeBain.tscn       → Écran de transition création/jeu
CreationUI.tscn        → Popup de création de personnage
Appartement3D.tscn     → Scène 3D principale (jeu)
Appartement.tscn       → [Non utilisé - peut être supprimé]
```

## 📜 SCRIPTS (.gd)
```
MenuPrincipal.gd       → Logique du menu (boutons, musique)
SalleDeBain.gd         → Gère le flux création/chargement
creation_ui.gd         → Interface de création personnage
Appartement3D.gd       → Logique de la scène 3D (NEW ✨)
Player.gd              → Contrôle du joueur (WASD, saut)
Miroir.gd              → Interaction avec miroir (non utilisé actuellement)
SaveManager.gd         → Singleton de gestion sauvegardes (NEW ✨)
Appartement.gd         → [Non utilisé - peut être supprimé]
```

## 📦 ASSETS
```
assets/
├── audio/
│   └── menu_music.ogg       → Musique du menu
└── images/
    └── menu_background.jpg  → Fond du menu
```

## ⚙️ CONFIGURATION
```
project.godot          → Configuration Godot (inputs, autoload)
icon.svg               → Icône du projet
.gitignore             → Fichiers à ignorer par Git
.gitattributes         → Configuration Git
.editorconfig          → Configuration éditeur
LICENSE                → Licence du projet
```

## 📖 DOCUMENTATION (NEW ✨)
```
README.md              → Documentation complète du projet
CORRECTIONS.md         → Liste détaillée des bugs corrigés
RESUME.md              → Résumé des réparations
DEMARRAGE.md           → Guide de démarrage rapide
STRUCTURE.md           → Ce fichier
```

## 🗂️ FICHIERS GODOT (générés)
```
.godot/                → Cache et données Godot (NE PAS MODIFIER)
├── editor/            → Configuration éditeur
├── imported/          → Assets importés
├── shader_cache/      → Cache des shaders
├── uid_cache.bin      → Cache des UID
└── ...
```

## 🆔 FICHIERS UID (.uid)
```
Appartement.gd.uid
Appartement3D.gd.uid   (NEW ✨)
creation_ui.gd.uid
MenuPrincipal.gd.uid
Miroir.gd.uid
Player.gd.uid
SalleDeBain.gd.uid
SaveManager.gd.uid     (NEW ✨)
```

---

## 🎯 FICHIERS PRINCIPAUX À CONNAÎTRE

### Pour le gameplay :
- `Player.gd` → Déplacement du joueur
- `Appartement3D.tscn` → Environnement du jeu
- `SaveManager.gd` → Sauvegardes

### Pour l'interface :
- `MainMenu.tscn` + `MenuPrincipal.gd` → Menu
- `CreationUI.tscn` + `creation_ui.gd` → Création perso

### Pour la configuration :
- `project.godot` → Paramètres du jeu

---

## 🗑️ FICHIERS À SUPPRIMER (optionnel)

Ces fichiers ne sont plus utilisés :
- `Appartement.tscn`
- `Appartement.gd`
- `Miroir.gd` (si pas d'utilisation prévue)

⚠️ **NE SUPPRIME PAS LE DOSSIER `.godot/` !**

---

## 📊 STATISTIQUES

```
Scènes actives      : 4
Scripts actifs      : 7
Assets audio        : 1
Assets images       : 1
Documentation       : 5 fichiers
Lignes de code      : ~400 (estimé)
```

---

## 🔄 DÉPENDANCES

```
Godot Engine    : 4.5+
GDScript        : 2.0
Rendering       : Mobile (optimisé)
```

---

**Projet bien organisé et documenté !** ✅
