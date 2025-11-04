# 🚀 GUIDE DE DÉMARRAGE RAPIDE - SHADOWS OF INQUIRY

## ✅ ÉTAPE 1 : VÉRIFICATION DU PROJET

Le projet a été **entièrement corrigé** le 1er novembre 2025.

### Erreurs corrigées :
1. ✅ **InventoryUI.gd** - Propriétés StyleBoxFlat corrigées
2. ✅ **Inventory.gd** - Syntaxe class_name corrigée
3. ✅ Tous les scripts vérifiés et fonctionnels

---

## 🎮 ÉTAPE 2 : LANCER LE JEU

### Dans Godot :
1. Ouvrir **Godot 4.5**
2. Importer le projet depuis : `C:\Users\niko9\Documents\shadows-inquiry`
3. Attendre la compilation des shaders (peut prendre 1-2 minutes)
4. Appuyer sur **F5** ou cliquer sur ▶️ **Play**

### Ce qui devrait se passer :
- ✅ Le menu principal s'affiche
- ✅ La musique de menu démarre
- ✅ Pas d'erreur dans la console

---

## 🐛 SI DES ERREURS APPARAISSENT

### 1. "Unrecognized file type 'resource'"
**Cause** : Fichier `default_bus_layout.tres` corrompu

**Solution rapide** :
```gdscript
# Supprimer le fichier
# Il sera recréé automatiquement
```

### 2. Autres erreurs de parsing
**Solution** : Vérifier que tous les fichiers .tscn/.tres s'ouvrent sans erreur dans l'éditeur

---

## 🎯 FLUX DE JEU

```
MainMenu.tscn (Menu Principal)
    ↓
CharacterCreation.tscn (Création du personnage)
    ↓
Appartement3D.tscn (Réveil dans l'appartement)
    ↓
Commissariat.tscn (Entretien d'embauche)
    ↓
CommissariatHub.tscn (Hub central - Enquêtes)
```

---

## 🎨 PERSONNALISATION DU PERSONNAGE

Dans **CharacterCreation.tscn**, vous pouvez modifier :

- 👤 **Nom et Prénom**
- 🎂 **Âge** (18-70 ans)
- 💇 **Coiffure** (10 styles)
- 🎨 **Couleur cheveux** (9 couleurs)
- 🧔 **Barbe** (8 styles + None)
- 🎨 **Couleur barbe**
- 🧏 **Moustache** (6 styles + None)
- ⚖️ **Corpulence** (-2 à +2)
- 💪 **Poids** (calculé automatiquement)

---

## 💾 SYSTÈME DE SAUVEGARDE

### Sauvegarde automatique
- ✅ **Toutes les 30 secondes**
- ✅ **À chaque changement de scène**
- ✅ **Fichier unique** : `user://sauvegarde_unique.json`

### Localisation Windows :
```
C:\Users\[VotreNom]\AppData\Roaming\Godot\app_userdata\ShadowsInquiry\sauvegarde_unique.json
```

### Supprimer la sauvegarde :
- Dans le menu principal, choisir **"New Game"**
- Ou supprimer manuellement le fichier JSON

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

---

## 🔧 FICHIERS PRINCIPAUX

### Singletons (Autoload)
- **Global.gd** → Données joueur, stats, progression
- **Inventory.gd** → Système d'inventaire

### Scènes principales
1. `MainMenu.tscn` → Point d'entrée
2. `CharacterCreation.tscn` → Création perso
3. `Appartement3D.tscn` → Appartement 3D
4. `Commissariat.tscn` → Commissariat
5. `CommissariatHub.tscn` → Hub enquêtes

### UI
- `InventoryUI.tscn` → Interface inventaire
- `PauseMenu.tscn` → Menu pause
- `OptionsMenu.tscn` → Options

---

## 📊 SYSTÈME DE STATS (Cachées)

Le joueur a **10 stats cachées** qui évoluent selon ses actions :

1. **Violence** - Force physique, combat
2. **Empathie** - Persuasion, écoute
3. **Intuition** - Détection d'indices
4. **Résilience** - Résistance mentale/physique
5. **Alliés** - Réseau de contacts
6. **Corruption** - Niveau de corruption (dangereux !)
7. **Santé Mentale** - État psychologique
8. **Réputation** - Image publique
9. **Ressources** - Argent, équipement
10. **Karma** - Moralité (-10 à +10)

---

## 🎲 SYSTÈME PUNITIF

Le jeu inclut un système **hardcore** :

- ⚠️ **Mort permanente** si détecté par caméras
- ⚠️ **Assassins aléatoires** dans les runs
- 🔁 **Runs multiples** avec échos du précédent
- 📹 **Caméras de surveillance** partout
- 🎭 **Choix moraux** qui suivent le joueur

**Conseil** : Soyez prudent, chaque mort compte !

---

## 🔍 DÉBOGAGE

### Console Godot
Ouvrir l'onglet **"Output"** en bas de Godot pour voir :
- ✅ Messages de confirmation (en vert)
- ⚠️ Avertissements (en jaune)
- ❌ Erreurs (en rouge)

### Messages importants :
```
=== INVENTORY SYSTEM INITIALIZED ===
=== GLOBAL SINGLETON INITIALISÉ ===
=== MENU PRINCIPAL ===
✓ Sauvegarde chargée
✓ Auto-save
```

---

## 💡 ASTUCES

### Pour tester rapidement :
1. Créer un personnage
2. Aller dans l'appartement
3. Tester l'inventaire (touches 1-0)
4. Sauvegarder (automatique)
5. Quitter et recharger → Progression conservée

### Pour voir les stats :
```gdscript
# Dans la console Godot (Remote > Inspector)
print(Global.donnees_joueur.stats)
```

---

## 📝 CHECKLIST AVANT DE JOUER

- [ ] Godot 4.5 installé
- [ ] Projet importé sans erreur
- [ ] Shaders compilés (1-2 min la première fois)
- [ ] Console Godot sans erreur rouge
- [ ] Musique de menu audible

---

## 🎉 C'EST PARTI !

Le jeu est **prêt à l'emploi**. Toutes les corrections ont été appliquées.

**Appuyez sur F5 et profitez du jeu ! 🚀**

---

_Guide créé le 1er novembre 2025_
_Projet : Shadows of Inquiry_
_Version : 1.0 - Build Corrigé_
