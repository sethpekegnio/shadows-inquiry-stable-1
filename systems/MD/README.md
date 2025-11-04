# 🕵️ SHADOWS OF INQUIRY

Jeu d'enquête à la première personne créé avec Godot 4.5

---

## 🎮 CONCEPT

Vous incarnez un inspecteur qui explore un appartement mystérieux pour résoudre une enquête. Le jeu commence par la création de votre personnage (sexe, âge), puis vous plonge dans l'exploration 3D de l'environnement.

---

## 🎯 ÉTAT ACTUEL DU PROJET

### ✅ Fonctionnalités implémentées :
- **Menu principal** avec musique
- **Système de sauvegarde** (création de personnage)
- **Exploration 3D** avec contrôles FPS
- **Déplacement** : WASD
- **Saut** : Espace
- **Gravité** et physique de base
- **Environnement 3D** avec sol et murs

### 🔧 En développement :
- Système d'interaction avec les objets
- Dialogues et narration
- Énigmes à résoudre
- Interface d'inventaire
- Plus de pièces à explorer

---

## 🚀 COMMENT LANCER LE JEU

1. Ouvrir le projet dans **Godot 4.5**
2. Appuyer sur **F5** ou cliquer sur "▶ Lancer"
3. Créer votre personnage
4. Explorer l'appartement !

---

## 🎮 CONTRÔLES

| Touche | Action |
|--------|--------|
| **W** | Avancer |
| **A** | Gauche |
| **S** | Reculer |
| **D** | Droite |
| **Espace** | Sauter |
| **Échap** | Quitter (à implémenter) |

---

## 📁 STRUCTURE DU PROJET

```
shadows-inquiry/
├── MainMenu.tscn          # Menu principal du jeu
├── SalleDeBain.tscn       # Écran intermédiaire (à retravailler)
├── CreationUI.tscn        # Popup de création de personnage
├── Appartement3D.tscn     # Scène 3D principale
├── Appartement.tscn       # Non utilisé (à supprimer/repenser)
├── MenuPrincipal.gd       # Logique du menu
├── SalleDeBain.gd         # Gestion du flux de jeu
├── creation_ui.gd         # Création du personnage
├── Player.gd              # Contrôle du joueur en 3D
├── Miroir.gd              # Interaction avec miroir (à développer)
└── assets/
    ├── audio/
    │   └── menu_music.ogg
    └── images/
        └── menu_background.jpg
```

---

## 🛠️ TECHNOLOGIES UTILISÉES

- **Moteur** : Godot 4.5
- **Langage** : GDScript
- **Rendu** : Mobile (optimisé pour performances)

---

## 📝 TODO / ROADMAP

### Priorité haute :
- [ ] Ajouter un menu pause
- [ ] Système d'interaction (E pour interagir)
- [ ] Ajouter des objets interactifs (indices, portes, téléphone)
- [ ] Système de dialogue/narration

### Priorité moyenne :
- [ ] Ajouter plus de pièces (chambre, cuisine, salon)
- [ ] Système d'inventaire
- [ ] Sons d'ambiance et effets sonores
- [ ] Éclairage dynamique (lampes interruptibles)

### Priorité basse :
- [ ] Système de checkpoints
- [ ] Options graphiques
- [ ] Sous-titres
- [ ] Achievements

---

## 🐛 BUGS CONNUS

Aucun bug critique connu actuellement. Tous les bugs majeurs du code initial ont été corrigés.

---

## 👤 AUTEUR

Projet créé et corrigé avec l'aide de Claude (Anthropic).

---

## 📜 LICENCE

Voir le fichier `LICENSE` à la racine du projet.
