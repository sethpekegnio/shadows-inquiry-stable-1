# 🕵️ SHADOWS OF INQUIRY

Un jeu d'enquête narratif en 3D avec système de mort permanente et runs multiples.

```
╔═══════════════════════════════════════════════════════════════════════╗
║                         PROJET OPÉRATIONNEL ✅                         ║
║                   Dernière correction : 01/11/2025                     ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## 🎮 APERÇU DU JEU

**Shadows of Inquiry** est un jeu d'enquête criminelle où vous incarnez un détective qui doit résoudre des cas tout en gérant sa santé mentale, sa réputation et ses choix moraux. Chaque décision compte et peut avoir des conséquences permanentes.

### 🌟 Caractéristiques principales :
- 🕵️ **Enquêtes complexes** avec indices à collecter et déductions
- 🎭 **Système de stats cachées** qui évoluent selon vos actions
- 💀 **Mort permanente** - Les erreurs peuvent être fatales
- 🔁 **Runs multiples** avec échos de la partie précédente
- 📹 **Système punitif** - Caméras et assassins vous guettent
- 🎨 **Création de personnage** complète et détaillée
- 💾 **Sauvegarde automatique** pour ne jamais perdre votre progression

---

## 🚀 DÉMARRAGE RAPIDE

### Prérequis
- **Godot 4.5** ou supérieur
- **Windows/Linux/Mac** (testé sur Windows)

### Installation
1. Télécharger ou cloner le projet
2. Ouvrir **Godot 4.5**
3. Importer le projet : `project.godot`
4. Appuyer sur **F5** pour lancer

### Premier lancement
1. Le menu principal s'affiche
2. Cliquer sur **"Play"** ou **"New Game"**
3. Créer votre personnage
4. Commencer l'enquête !

📖 **Guide complet** : [`GUIDE_DEMARRAGE.md`](GUIDE_DEMARRAGE.md)

⚡ **Test rapide** : [`TEST_RAPIDE_5MIN.md`](TEST_RAPIDE_5MIN.md)

---

## 🎯 GAMEPLAY

### Point & Click 3D
- **Clic gauche** : Déplacer / Interagir
- **Clic droit** : Déplacement forcé
- **Hover** : Afficher les informations

### Système d'inventaire
- **10 slots** avec raccourcis touches **1-0**
- **Combiner des objets** pour résoudre des énigmes
- **Actions contextuelles** selon l'item sélectionné

### Progression narrative
```
Menu Principal
    ↓
Création de Personnage
    ↓
Appartement (Réveil)
    ↓
Commissariat (Entretien)
    ↓
Hub d'Enquêtes
    ↓
Investigations...
```

---

## 📊 SYSTÈME DE STATS

Votre personnage possède **10 stats cachées** :

| Stat | Description |
|------|-------------|
| 💪 **Violence** | Force physique, efficacité au combat |
| ❤️ **Empathie** | Capacité à persuader et comprendre |
| 🔍 **Intuition** | Détection d'indices et de mensonges |
| 🛡️ **Résilience** | Résistance physique et mentale |
| 👥 **Alliés** | Réseau de contacts et soutiens |
| 🔒 **Corruption** | Niveau de compromission (dangereux) |
| 🧠 **Santé Mentale** | État psychologique (baisse avec le gore) |
| ⭐ **Réputation** | Image publique et crédibilité |
| 💰 **Ressources** | Argent et équipement |
| ⚖️ **Karma** | Moralité (-10 à +10) |

---

## ⚠️ SYSTÈME PUNITIF

Le jeu inclut un système **hardcore** :

- 📹 **Caméras de surveillance** partout - Être vu = mort
- 🔪 **Assassins aléatoires** dans certains runs
- 💀 **Mort permanente** - Recommencer depuis le début
- 🔁 **Échos du run précédent** - Vos actions passées vous hantent
- ⚠️ **Conséquences permanentes** de vos choix

**Conseil** : Restez vigilant et planifiez vos actions !

---

## 🎮 CONTRÔLES

| Touche | Action |
|--------|--------|
| **Z** | Avancer |
| **S** | Reculer |
| **Q** | Gauche |
| **D** | Droite |
| **E** | Interagir |
| **1-0** | Sélection rapide inventaire |
| **Échap** | Menu pause |
| **Tab** | Inventaire (dans certaines scènes) |
| **Clic gauche** | Déplacer / Interagir |
| **Clic droit** | Déplacement forcé |

---

## 💾 SAUVEGARDE

- ⏱️ **Auto-save** toutes les 30 secondes
- 💾 **Sauvegarde** à chaque changement de scène
- 📁 **Fichier unique** : `user://sauvegarde_unique.json`
- 🔄 **Continue** au menu principal pour reprendre

---

## 📂 STRUCTURE DU PROJET

```
shadows-inquiry/
├── 📁 assets/               # Ressources (audio, images)
├── 📁 scenes/              # Scènes organisées
│   ├── menus/
│   ├── locations/
│   └── ui/
├── 📁 scripts/             # Scripts auxiliaires
├── 📄 Global.gd            # Singleton - Données globales
├── 📄 Inventory.gd         # Singleton - Inventaire
├── 📄 *.tscn               # Scènes principales
└── 📄 project.godot        # Configuration
```

---

## 🛠️ ÉTAT DU PROJET

### ✅ Fonctionnel
- Menu principal avec musique
- Création de personnage complète
- Système d'inventaire (10 slots)
- Sauvegarde automatique
- Point & Click 3D
- Système de stats
- Menu pause

### 🔄 En développement
- Système de dialogue complet
- Enquêtes avec indices
- Combat et animations
- Système de caméras
- Mort permanente avec échos

### 📋 Planifié
- Plus d'enquêtes
- Modèles 3D de personnages
- Sons et musiques additionnels
- Système de déduction visuel
- Fins multiples

📊 **État détaillé** : [`ETAT_FINAL.md`](ETAT_FINAL.md)

---

## 📚 DOCUMENTATION

| Document | Description |
|----------|-------------|
| [`INDEX_DOCUMENTATION.md`](INDEX_DOCUMENTATION.md) | Index général de toute la documentation |
| [`GUIDE_DEMARRAGE.md`](GUIDE_DEMARRAGE.md) | Guide complet pour démarrer |
| [`TEST_RAPIDE_5MIN.md`](TEST_RAPIDE_5MIN.md) | Test en 5 minutes |
| [`PROJET_CORRIGE.md`](PROJET_CORRIGE.md) | Détails des corrections |
| [`RAPPORT_REPARATION.md`](RAPPORT_REPARATION.md) | Rapport technique |
| [`ETAT_FINAL.md`](ETAT_FINAL.md) | État complet du projet |
| [`STRUCTURE.md`](STRUCTURE.md) | Architecture du projet |
| [`ROADMAP.md`](ROADMAP.md) | Feuille de route |
| [`CHANGELOG.md`](CHANGELOG.md) | Historique des versions |

---

## 🐛 DÉBOGAGE

### Problèmes courants

**Le jeu ne démarre pas**
→ Vérifier que `run/main_scene="res://MainMenu.tscn"` dans project.godot

**Erreur "Invalid assignment"**
→ Vérifier les corrections dans [`PROJET_CORRIGE.md`](PROJET_CORRIGE.md)

**Erreur "Parse Error"**
→ Consulter [`RAPPORT_REPARATION.md`](RAPPORT_REPARATION.md)

**Plus d'aide** → [`GUIDE_DEMARRAGE.md`](GUIDE_DEMARRAGE.md) → Section "Dépannage"

---

## 🤝 CONTRIBUTION

### Comment contribuer ?
1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

### Standards de code
- **GDScript** pour tous les scripts
- **Commentaires** en français
- **Documentation** des fonctions principales
- **Tests** avant de commit

---

## 📄 LICENCE

Ce projet est sous licence **MIT** - voir le fichier [`LICENSE`](LICENSE) pour plus de détails.

---

## 👤 AUTEUR

**Seth Pékégnio**
- Portfolio : [En construction]
- Email : [À définir]

---

## 🙏 REMERCIEMENTS

- **Godot Engine** pour le moteur de jeu
- **Community Godot** pour le support
- **Testeurs** pour les retours

---

## 📊 STATISTIQUES

```
Version :        1.0 - Build Stable
Date :           1er Novembre 2025
Lignes de code : ~1010 (GDScript)
Fichiers :       27 scripts + scènes
Documentation :  10+ guides
Statut :         ✅ Opérationnel
```

---

## 🎯 QUICKSTART

```bash
# 1. Cloner le projet
git clone [URL_DU_REPO]

# 2. Ouvrir dans Godot 4.5
godot -e project.godot

# 3. Lancer le jeu
# Appuyer sur F5
```

---

## 🔗 LIENS UTILES

- [Documentation Godot](https://docs.godotengine.org/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
- [Godot Community](https://godotengine.org/community)

---

```
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                        ║
║              🎉  PRÊT À JOUER !  🎉                                   ║
║                                                                        ║
║     Appuyez sur F5 dans Godot et commencez l'enquête ! 🕵️            ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

_Dernière mise à jour : 1er Novembre 2025_
_Version : 1.0 - Build Stable_
_Projet : 100% Opérationnel ✅_
