# 🎮 SHADOWS OF INQUIRY - GUIDE VISUEL RAPIDE

**Version:** 0.1 | **Date:** 02/11/2025 | **Statut:** ✅ 100% Fonctionnel

---

## 📊 VUE D'ENSEMBLE RAPIDE

```
┌─────────────────────────────────────────────────────────┐
│  SHADOWS OF INQUIRY - Jeu d'enquête dystopique 3D      │
│  Godot 4.5.1 | GDScript | Vue dessus (style 12 Minutes)│
└─────────────────────────────────────────────────────────┘

🎯 CONCEPT
Inspecteur de police dans une ville dystopique
Résoudre enquêtes, gérer santé mentale, faire choix moraux
Mort = game over définitif | Retraite = seul score sauvé

📦 ÉTAT ACTUEL
✅ Sauvegarde auto (30 sec)
✅ Création personnage complète
✅ Navigation Appartement ↔ Commissariat
✅ 2 PNJ persistants
✅ Temps réel (1sec = 1min)
✅ Inventaire 10 cases (raccourcis 1-0)
✅ Menu pause (Échap)

🚧 PRIORITÉS
1. Téléphone (10 numéros, répondeur)
2. Magasins (objets, vêtements, armes)
3. Dialogues PNJ
4. Questionnaire stats (6 questions)
```

---

## 🗺️ ARCHITECTURE VISUELLE

### Structure Dossiers
```
shadows-inquiry/
│
├── 📁 systems/                    ← CŒUR DU JEU
│   │
│   ├── 📁 scenes/
│   │   └── 📁 locations/
│   │       ├── 🏠 MainMenu.tscn
│   │       ├── 👤 CharacterCreation.tscn
│   │       ├── 🏢 Appartement3D.tscn
│   │       ├── 🚔 Commissariat.tscn
│   │       ├── 👥 PNJ.tscn
│   │       ├── ⏸️  PauseMenu.tscn
│   │       └── 🎒 InventoryUI.tscn
│   │
│   └── 📁 scripts/
│       ├── 🌍 Global.gd (Singleton)
│       ├── 🎒 Inventory.gd (Singleton)
│       ├── 👥 PNJDatabase.gd (Singleton)
│       ├── 🏠 MenuPrincipal.gd
│       ├── 👤 CharacterCreation.gd
│       ├── 🏢 Appartement3D.gd
│       ├── 🚔 Commissariat.gd
│       ├── 👥 PNJ.gd
│       ├── 🚪 Porte.gd
│       └── ⏸️  PauseMenu.gd
│
├── 📁 addons/                     ← Assets 3D externes
├── 📄 project.godot               ← Config Godot
└── 📄 ANALYSE_COMPLETE_CLAUDE.md  ← Ce document complet
```

---

## 🎬 FLOW DU JEU (VISUEL)

### Nouvelle Partie
```
╔═══════════════════════════════════════════════════════════╗
║  1. MENU PRINCIPAL                                        ║
║  ┌──────────────────────────────┐                         ║
║  │  SHADOWS OF INQUIRY          │                         ║
║  │                               │                         ║
║  │  [New Game] ◄──── Pas de save│                         ║
║  │  [Options]                    │                         ║
║  │  [Quit]                       │                         ║
║  │                               │                         ║
║  │  Edited by Seth 2025          │                         ║
║  └──────────────────────────────┘                         ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic "New Game"
                     ↓
╔═══════════════════════════════════════════════════════════╗
║  2. CRÉATION PERSONNAGE                                   ║
║  ┌──────────────┬────────────────────────────────────┐   ║
║  │   MIROIR     │     CUSTOMISATION                  │   ║
║  │  ┌────────┐  │  Hair Style: 1-10                  │   ║
║  │  │Preview │  │  Hair Color: 9 choix               │   ║
║  │  │  🧑     │  │  Beard: 0-8 styles                 │   ║
║  │  └────────┘  │  Moustache: 0-6 styles             │   ║
║  │              │  Corpulence: -2.0 à +2.0           │   ║
║  └──────────────┴────────────────────────────────────┘   ║
║  ┌────────────────────────────────────────────────────┐  ║
║  │  CARTE D'IDENTITÉ                                  │  ║
║  │  Name: [________]  First: [________]               │  ║
║  │  Age: [30]         Weight: 75kg                    │  ║
║  │                                                     │  ║
║  │  [Cancel]  [Confirm] ◄── Valide et sauvegarde     │  ║
║  └────────────────────────────────────────────────────┘  ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic "Confirm"
                     ↓
╔═══════════════════════════════════════════════════════════╗
║  3. APPARTEMENT 3D (Hub Joueur)                          ║
║  ┌────────────────────────────────────────────────────┐  ║
║  │ Detective John DOE | Age: 30 | Weight: 75kg       │  ║
║  └────────────────────────────────────────────────────┘  ║
║                                                           ║
║         📞 Téléphone      🎒 Inventaire                   ║
║            (à impl.)      [■][■][■][■][■]                ║
║                           [■][■][■][■][■]                ║
║              👤                                           ║
║             (Toi)          🚪 Porte                       ║
║                            (destinations)                 ║
║                                                           ║
║  Contrôles: Clic gauche = Déplacer/Interagir            ║
║            Clic droit = Forcer déplacement               ║
║            Échap = Pause                                  ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic Porte 🚪
                     ↓
╔═══════════════════════════════════════════════════════════╗
║  MENU DESTINATIONS                                        ║
║  ┌────────────────────────────────────────────────────┐  ║
║  │  SELECT DESTINATION                                 │  ║
║  │  ──────────────────────────────────────             │  ║
║  │  [Precinct] ◄── Commissariat                       │  ║
║  │  [Shops]    ◄── Magasins (à créer)                 │  ║
║  │  [Enter Address...] ◄── Adresse libre              │  ║
║  │                                                     │  ║
║  │  [Cancel]                                           │  ║
║  └────────────────────────────────────────────────────┘  ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic "Precinct"
                     ↓
╔═══════════════════════════════════════════════════════════╗
║  4. COMMISSARIAT (Hub Police)                            ║
║  ┌────────────────────────────────────────────────────┐  ║
║  │ Jour 1 | 08:23 ◄── Temps réel (1sec = 1min)        │  ║
║  └────────────────────────────────────────────────────┘  ║
║                                                           ║
║              [RECEPTION]                                  ║
║                  👤 Marie DUPONT                          ║
║              [RECEPTION]                                  ║
║                                                           ║
║  [MY OFFICE]              [CHIEF'S OFFICE]               ║
║                               👤 Jean MARTIN              ║
║                           [DIRECTEUR]                     ║
║                                                           ║
║         [INTERROGATION ROOM]                              ║
║                                                           ║
║  🚪 [EXIT]                                                ║
║                                                           ║
║  Layout: Reception (centre), Bureaux (côtés),            ║
║          Salle interrogatoire (arrière), Sortie (gauche) ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic Porte 🚪
                     ↓
╔═══════════════════════════════════════════════════════════╗
║  MENU DESTINATIONS (Commissariat)                        ║
║  ┌────────────────────────────────────────────────────┐  ║
║  │  [Apartment] ◄── Retour appartement uniquement     │  ║
║  │  [Cancel]                                           │  ║
║  └────────────────────────────────────────────────────┘  ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic "Apartment"
                     ↓
              RETOUR APPARTEMENT
              (Boucle complète !)
```

### Continue (Partie existante)
```
╔═══════════════════════════════════════════════════════════╗
║  MENU PRINCIPAL                                           ║
║  ┌──────────────────────────────┐                         ║
║  │  [Continue] ◄── Save détectée│                         ║
║  │  [Options]                    │                         ║
║  │  [Quit]                       │                         ║
║  └──────────────────────────────┘                         ║
╚═══════════════════════════════════════════════════════════╝
                     │ Clic "Continue"
                     ↓
         Charge Global.donnees_joueur
         Détecte "progression"
                     │
         ┌───────────┴───────────┐
         │                       │
    "appartement_debut"    "commissariat"
         │                       │
         ↓                       ↓
  APPARTEMENT 3D          COMMISSARIAT
  (Skip création)          (Direct)
```

---

## 💾 SYSTÈME SAUVEGARDE (VISUEL)

### Fichier sauvegarde
```
📁 %APPDATA%\Godot\app_userdata\ShadowsInquiry\
    └── 📄 sauvegarde_unique.json

Contenu:
{
  "first_name": "John",
  "last_name": "DOE",
  "age": 30,
  "progression": "appartement_debut",  ◄── CLEF ROUTING
  "temps_jeu": 120.0,
  "run_actuel": 1,
  
  "stats": {
    "Violence": 5,
    "Empathie": 5,
    "Intuition": 5,
    ...
  },
  
  "pnj": {  ◄── PNJ PERSISTANTS
    "directeur": {
      "prenom": "Jean",
      "nom": "MARTIN",
      "role": "directeur",
      ...
    },
    "reception": {...}
  }
}
```

### Auto-save timing
```
┌────────────────────────────────────────────────┐
│  T = 0 sec      │  Jeu démarre                │
│  T = 30 sec     │  ✅ Auto-save #1            │
│  T = 60 sec     │  ✅ Auto-save #2            │
│  T = 90 sec     │  ✅ Auto-save #3            │
│  ...            │  ...                         │
└────────────────────────────────────────────────┘

Sauvegarde également:
• Avant quitter (menu pause)
• Après création personnage
• Après confirmation questionnaire stats
```

---

## 👥 SYSTÈME PNJ (VISUEL)

### Génération
```
╔══════════════════════════════════════════════════════════╗
║  PNJDatabase.generer("directeur")                       ║
╚══════════════════════════════════════════════════════════╝
                     │
                     ↓
         ┌───────────────────────┐
         │  Genre aléatoire      │
         │  50% Male / 50% Female│
         └───────────────────────┘
                     │
                     ↓
         ┌───────────────────────┐
         │  Prénom selon genre   │
         │  Male: Jean, Luc...   │
         │  Female: Marie, Emma..│
         └───────────────────────┘
                     │
                     ↓
         ┌───────────────────────┐
         │  Nom aléatoire        │
         │  Dupont, Martin...    │
         └───────────────────────┘
                     │
                     ↓
         ┌───────────────────────┐
         │  Stats aléatoires     │
         │  Violence: 1-10       │
         │  Empathie: 1-10       │
         │  Intuition: 1-10      │
         └───────────────────────┘
                     │
                     ↓
╔══════════════════════════════════════════════════════════╗
║  {                                                       ║
║    "role": "directeur",                                 ║
║    "genre": "male",                                     ║
║    "prenom": "Jean",                                    ║
║    "nom": "MARTIN",                                     ║
║    "stats": {"Violence": 7, "Empathie": 4, ...}        ║
║  }                                                       ║
╚══════════════════════════════════════════════════════════╝
```

### Affichage 3D
```
PNJ.tscn
┌────────────────────────┐
│   Jean MARTIN          │ ◄── Label3D (billboard)
│   [DIRECTEUR]          │
│                        │
│       ╭───╮            │
│       │ ● │            │ ◄── Capsule colorée
│       ╰───╯            │     Bleu: Male
│        │ │             │     Rose: Female
│        │ │             │
│       ╱   ╲            │
│      /     \           │
└────────────────────────┘
```

---

## ⏰ SYSTÈME TEMPS (VISUEL)

### Horloge en jeu
```
╔══════════════════════════════════════════════════════════╗
║  TEMPS RÉEL                                              ║
╚══════════════════════════════════════════════════════════╝

Temps réel          Temps jeu           Affichage
────────────────────────────────────────────────────
T = 0 sec    →      08:00             "Jour 1 | 08:00"
T = 1 sec    →      08:01             "Jour 1 | 08:01"
T = 60 sec   →      09:00             "Jour 1 | 09:00"
T = 540 sec  →      17:00             "Jour 1 | 17:00"
T = 960 sec  →      24:00 → 00:00     "Jour 2 | 00:00"

╔══════════════════════════════════════════════════════════╗
║  ÉVÉNEMENTS PROGRAMMÉS (Futur)                          ║
╚══════════════════════════════════════════════════════════╝

08:00-09:00  │  Directeur arrive bureau
09:00-12:00  │  Directeur disponible
12:00-13:00  │  Directeur en pause
13:00-17:00  │  Directeur disponible
17:00-18:00  │  Directeur part
18:00-08:00  │  Bureau fermé

Événement aléatoires:
• 2-3 fois/jour: Duo policiers + interpelé
• 1 fois/jour: Femme de ménage (heure variable)
• 1 fois/semaine: Réunion obligatoire
```

---

## 🎒 INVENTAIRE (VISUEL)

### UI en haut d'écran
```
┌──────────────────────────────────────────────────────────┐
│  [1]  [2]  [3]  [4]  [5]  [6]  [7]  [8]  [9]  [0]       │
│   ↑                                                       │
│  Sélectionné (bordure dorée)                             │
│                                                           │
│  Vide: Gris | Occupé: Vert                               │
└──────────────────────────────────────────────────────────┘

Raccourcis clavier:
1, 2, 3, 4, 5, 6, 7, 8, 9, 0  →  Sélection directe
```

### Structure item
```
Item Dictionary:
{
  "id": "couteau_cuisine",
  "nom": "Couteau de cuisine",
  "type": "arme",
  "description": "Un simple couteau...",
  "icon": "res://assets/icons/knife.png",
  "stackable": false,
  "actions": ["Menacer", "Attaquer", "Couper"]
}

Utilisation:
1. Sélectionner slot (ex: touche 3)
2. Clic sur PNJ ou objet
3. Menu actions apparaît:
   ┌────────────────┐
   │  [Menacer]     │
   │  [Attaquer]    │
   │  [Couper]      │
   │  [Annuler]     │
   └────────────────┘
```

---

## 📊 STATS CACHÉES (VISUEL)

### 10 Stats principales
```
╔══════════════════════════════════════════════════════════╗
║  STATS JOUEUR (Visibles seulement miroir/fin)          ║
╚══════════════════════════════════════════════════════════╝

┌──────────────────┬─────────┬────────────────────────────┐
│ Stat             │ Range   │ Effet                      │
├──────────────────┼─────────┼────────────────────────────┤
│ Violence         │ 0-10    │ Dégâts, intimidation       │
│ Empathie         │ 0-10    │ Convaincre, comprendre PNJ │
│ Intuition        │ 0-10    │ Indices, détecter mensonges│
│ Resilience       │ 0-10    │ Résister blessures/stress  │
│ Allies           │ 0-10    │ Réseau contacts            │
│ Corruption       │ 0-10    │ Risque trahison (haut=bad) │
│ SanteMentale     │ 0-10    │ Baisse avec gore/échecs    │
│ Reputation       │ 0-10    │ Opinion publique           │
│ Ressources       │ 0-10    │ Argent, équipement         │
│ Karma            │ -10/+10 │ Choix moraux (bon/mauvais) │
└──────────────────┴─────────┴────────────────────────────┘

Modification:
Global.modifier_stat("Violence", +2)  → Violence passe de 5 à 7
Global.modifier_stat("Karma", -3)     → Karma passe de 0 à -3
```

### Questionnaire (6 questions)```
┌─────────────────────────────────────────────────────────┐
│ Q1: Face à suspect menteur ?                           │
│   A. Le frappes          → Violence +2                 │
│   B. Observes silencieux → Intuition +2                │
│   C. Perche empathique   → Empathie +2                 │
├─────────────────────────────────────────────────────────┤
│ Q2: Collègue corrompu pot-de-vin ?                     │
│   A. Acceptes            → Corruption +1, Ressources +1│
│   B. Refuses poliment    → Karma +1                    │
│   C. Le dénonces         → Reputation +2, Allies -1    │
├─────────────────────────────────────────────────────────┤
│ Q3: Scène gore ?                                        │
│   A. T'excites           → Violence +1, SanteMentale -1│
│   B. Analyses froidement → Intuition +2                │
│   C. Te révuls           → SanteMentale -2, Empathie +1│
├─────────────────────────────────────────────────────────┤
│ Q4: Allié te trahit ?                                   │
│   A. Vengeance           → Violence +2, Allies -2      │
│   B. Pardonnes           → Empathie +2, Karma +1       │
│   C. Utilises contre lui → Intuition +2, Karma -1      │
├─────────────────────────────────────────────────────────┤
│ Q5: Run raté ?                                          │
│   A. Relèves plus dur    → Resilience +2               │
│   B. Réfléchis erreurs   → Intuition +2                │
│   C. Cherches soutien    → Allies +2                   │
├─────────────────────────────────────────────────────────┤
│ Q6: Sur balcon retraite ?                               │
│   A. Défies              → Violence +2, Karma -1       │
│   B. Murmures secret     → Intuition +2                │
│   C. Tends main          → Empathie +2, Karma +2       │
└─────────────────────────────────────────────────────────┘
```

---

## 🚪 SYSTÈME PORTES (VISUEL)

### Menu destinations (Appartement)
```
╔══════════════════════════════════════════════════════════╗
║  SELECT DESTINATION                                      ║
║  ──────────────────────────────────────────              ║
║                                                           ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [Precinct]              ◄── Commissariat        │   ║
║  │  Commissariat de police                           │   ║
║  └──────────────────────────────────────────────────┘   ║
║                                                           ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [Shops]                 ◄── Magasins (à créer)  │   ║
║  │  Centre commercial                                │   ║
║  └──────────────────────────────────────────────────┘   ║
║                                                           ║
║  ──────────────────────────────────────────              ║
║  Or enter address manually:                              ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [Type exact address...]                          │   ║
║  │  (case sensitive)                                 │   ║
║  └──────────────────────────────────────────────────┘   ║
║                                                           ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [🔍 GO TO ADDRESS]                               │   ║
║  └──────────────────────────────────────────────────┘   ║
║                                                           ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [Cancel]                                         │   ║
║  └──────────────────────────────────────────────────┘   ║
╚══════════════════════════════════════════════════════════╝

Adresses valides (saisie manuelle):
• "Commissariat"  → Commissariat.tscn
• "Magasins"      → Magasins.tscn
• "Appartement"   → Appartement3D.tscn
```

### Menu destinations (Commissariat)
```
╔══════════════════════════════════════════════════════════╗
║  SELECT DESTINATION                                      ║
║  ──────────────────────────────────────────              ║
║                                                           ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [Apartment]             ◄── Retour uniquement    │   ║
║  │  Votre appartement                                │   ║
║  └──────────────────────────────────────────────────┘   ║
║                                                           ║
║  ┌──────────────────────────────────────────────────┐   ║
║  │  [Cancel]                                         │   ║
║  └──────────────────────────────────────────────────┘   ║
╚══════════════════════════════════════════════════════════╝
```

---

## 🎛️ CONTRÔLES RÉSUMÉ

### En jeu (Appartement / Commissariat)
```
┌────────────────────────────────────────────────────────┐
│  🖱️ SOURIS                                             │
├────────────────────────────────────────────────────────┤
│  Clic gauche     │  Déplacer (sol) ou Interagir (objet)│
│  Clic droit      │  Forcer déplacement                 │
│  Survol          │  Afficher nom objet interactif      │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│  ⌨️ CLAVIER                                            │
├────────────────────────────────────────────────────────┤
│  1, 2, 3..., 0   │  Sélectionner slot inventaire       │
│  E               │  Interagir (alternatif clic)        │
│  Échap           │  Menu pause                         │
└────────────────────────────────────────────────────────┘
```

### Menu Pause
```
┌────────────────────────────────────────────────────────┐
│  Échap          │  Ouvrir/fermer menu pause           │
│  Clic boutons   │  Resume / Options / Main Menu / Quit│
└────────────────────────────────────────────────────────┘
```

---

## 🛠️ CHECKLIST RAPIDE DÉVELOPPEUR

### ✅ FAIT (100% fonctionnel)
```
[✅] Sauvegarde automatique (30 sec)
[✅] Menu New Game / Continue
[✅] Création personnage complète
[✅] Appartement 3D navigable
[✅] Commissariat fonctionnel
[✅] PNJ génération + persistance
[✅] Système temps réel
[✅] Déplacement clic souris
[✅] Menu pause
[✅] Inventaire UI haut écran
[✅] Transitions scènes fluides
[✅] Portes Appartement ↔ Commissariat
```

### 🚧 PRIORITÉ 1 (Features utilisateur demandées)
```
[⏳] Téléphone
    └─ 10 numéros enregistrables
    └─ Répondeur
    └─ Pavé numérique
    └─ Sonnerie + animation

[⏳] Magasins
    └─ Scène Magasins.tscn à créer
    └─ Catégories: Meubles, Vêtements, Armes
    └─ Système achat/argent
    └─ Inventaire intégration

[⏳] Questions stats
    └─ 6 questions à implémenter
    └─ Interface UI questionnaire
    └─ Modification stats selon réponses
    └─ Intégration création perso ou miroir

[⏳] Portes destinations complètes
    └─ Magasins accessible
    └─ Adresse libre fonctionnelle
    └─ Validation adresses personnalisées
```

### 📋 PRIORITÉ 2 (Polish)
```
[  ] Sons
    └─ Footsteps
    └─ Portes
    └─ Téléphone
    └─ Ambiances (appartement, commissariat)

[  ] Musiques
    └─ Menu (déjà présent)
    └─ Appartement (calme)
    └─ Commissariat (bureaucratique)
    └─ Tension (enquêtes)

[  ] Textures HD
    └─ Sols (bois, carrelage)
    └─ Murs (peinture, papier peint)
    └─ Meubles détaillés

[  ] Modèles 3D personnages
    └─ Remplacer capsules par models
    └─ Animations (idle, marche)
    └─ Expressions faciales

[  ] Multi-langue
    └─ Français (actuel)
    └─ Anglais
    └─ Système localization
```

### 🎮 PRIORITÉ 3 (Gameplay avancé)
```
[  ] Système punitif
    └─ Caméras détection
    └─ Assassins échos runs
    └─ Conséquences actions

[  ] Dialogues PNJ
    └─ Arbre conversations
    └─ Choix multiples
    └─ Impact stats

[  ] Enquêtes complètes
    └─ 10+ affaires
    └─ Indices collecte
    └─ Résolution multiple

[  ] Score retraite
    └─ Calcul score final
    └─ Classement mondial (API)
    └─ Fins multiples
```

---

## 🐛 DÉBOGAGE RAPIDE

### Erreurs courantes
```
❌ "Invalid UID"
   ✅ FileSystem → Clic droit fichier → Reimport

❌ "Node not found"
   ✅ Vérifier chemin: $NodeName ou find_child()

❌ "Preload failed"
   ✅ Vérifier chemin complet: res://systems/...

❌ "donnees_joueur.pnj null"
   ✅ Vérifier Global.gd ligne 34: "pnj": {}

❌ Continue → Création perso
   ✅ Vérifier CharacterCreation.gd ligne 261: "appartement_debut"

❌ PNJ pas générés
   ✅ Vérifier Commissariat.gd: generate_and_spawn_pnj() appelé

❌ Temps ne défile pas
   ✅ Vérifier Timer créé et démarré dans Commissariat.gd
```

### Console utile
```
# Afficher progression actuelle
print(Global.donnees_joueur.progression)

# Afficher PNJ sauvegardés
print(Global.donnees_joueur.pnj)

# Afficher stats
print(Global.donnees_joueur.stats)

# Tester modification stat
Global.modifier_stat("Violence", 2)
print(Global.donnees_joueur.stats.Violence)
```

---

## 📈 PROGRESSION PROJET

### Temps développement
```
┌──────────────────────┬──────────┬──────────────┐
│ Phase                │ Temps    │ État         │
├──────────────────────┼──────────┼──────────────┤
│ Architecture         │ 10h      │ ✅ Terminé   │
│ Core systems         │ 20h      │ ✅ Terminé   │
│ Scènes + UI          │ 15h      │ ✅ Terminé   │
│ Debug + fixes        │ 10h      │ ✅ Terminé   │
│ Documentation        │ 5h       │ ✅ Terminé   │
├──────────────────────┼──────────┼──────────────┤
│ TOTAL                │ 60h      │ ✅ V0.1      │
└──────────────────────┴──────────┴──────────────┘

Prochaines phases estimées:
├─ Features P1       │ 30h      │ 🚧 En cours
├─ Polish P2         │ 20h      │ ⏳ À venir
├─ Gameplay P3       │ 40h      │ ⏳ À venir
└─ Contenu           │ 100h+    │ ⏳ À venir
```

### Statistiques code
```
📊 LIGNES DE CODE
├─ Global.gd              212 lignes
├─ CharacterCreation.gd   239 lignes
├─ Commissariat.gd        203 lignes
├─ Appartement3D.gd       176 lignes
├─ Porte.gd               169 lignes
├─ MenuPrincipal.gd        89 lignes
├─ PNJ.gd                  31 lignes
├─ PNJDatabase.gd          27 lignes
├─ Autres scripts        ~200 lignes
└─ TOTAL                ~1350 lignes
```

---

## 🎯 ROADMAP VISUELLE

```
VERSION 0.1 (Actuel) ✅
├─ Core systems 100% fonctionnels
├─ Menu + Sauvegarde
├─ Création perso
├─ 2 lieux (Appartement, Commissariat)
└─ 2 PNJ persistants

VERSION 0.2 (Prochain) 🚧
├─ Téléphone complet
├─ Magasins fonctionnels
├─ Questions stats
├─ Dialogues PNJ basiques
└─ Première enquête simple

VERSION 0.3 (Futur) ⏳
├─ Sons + musiques
├─ Textures HD
├─ Animations personnages
├─ Multi-langue
└─ 3 enquêtes complètes

VERSION 1.0 (Release) 🎯
├─ 10+ enquêtes
├─ 50+ PNJ
├─ 20+ lieux
├─ Système punitif complet
├─ Fins multiples
└─ Classement mondial
```

---

## 💡 ASTUCES DÉVELOPPEMENT

### Tester rapidement
```
# Dans Godot, F5 = Play projet complet
# F6 = Play scène actuelle (utile pour tester Commissariat direct)

# Pour tester Continue:
# 1. Play une fois (New Game → Confirme perso)
# 2. Quitte jeu
# 3. Relaunch → Bouton devient "Continue"
```

### Créer nouveau PNJ rapidement
```gdscript
# Dans n'importe quelle scène
var nouveau_pnj_data = PNJDatabase.generer("custom_role")
nouveau_pnj_data.prenom = "Override"  # Optionnel
nouveau_pnj_data.nom = "CUSTOMNAME"

var spawn_pos = Vector3(x, y, z)
spawn_pnj(nouveau_pnj_data, spawn_pos)
```

### Modifier stats en jeu (debug)
```gdscript
# Ajouter boutons debug temporaires
func _input(event):
    if event.is_action_pressed("ui_page_up"):
        Global.modifier_stat("Violence", 1)
        print("Violence: ", Global.donnees_joueur.stats.Violence)
    
    if event.is_action_pressed("ui_page_down"):
        Global.modifier_stat("Violence", -1)
```

---

## 📞 RÉFÉRENCES RAPIDES

### Fichiers clés à connaître
```
🔑 ESSENTIELS
├─ Global.gd                 → Données joueur + save
├─ project.godot             → Config projet
├─ MainMenu.tscn             → Point d'entrée
└─ ANALYSE_COMPLETE_CLAUDE.md → Doc complète

📖 DOCUMENTATION
├─ ARCHITECTURE.md           → Structure projet
├─ PROJET.md                 → État actuel
├─ TEST_RAPIDE.md            → Guide test
└─ GUIDE_VISUEL_RAPIDE.md    → Ce fichier
```

### Chemins importants
```
📂 SCÈNES
res://systems/scenes/locations/

📜 SCRIPTS
res://systems/scripts/

🎨 ASSETS
res://systems/assets/

💾 SAUVEGARDE
user://sauvegarde_unique.json
(%APPDATA%\Godot\app_userdata\ShadowsInquiry\)
```

---

## 🎉 FÉLICITATIONS !

Vous avez maintenant une **vision complète** du projet **Shadows of Inquiry** !

### Ce qui fonctionne ✅
- Tout le core gameplay
- Sauvegarde robuste
- Navigation fluide
- PNJ persistants
- Temps réel

### Ce qui reste à faire 🚧
- Téléphone
- Magasins
- Questions stats
- Contenu (enquêtes, dialogues)
- Polish (sons, textures, animations)

### Pour aller plus loin 📚
Consultez `ANALYSE_COMPLETE_CLAUDE.md` pour:
- Détails techniques approfondis
- Guides développement étape par étape
- Exemples code complets
- Système punitif avancé
- Roadmap détaillée

---

**Document créé le:** 02/11/2025  
**Projet:** Shadows of Inquiry v0.1  
**Moteur:** Godot 4.5.1  
**Statut:** ✅ Core 100% Fonctionnel

*Bon développement ! 🚀*