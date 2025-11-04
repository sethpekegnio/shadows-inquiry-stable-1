# 🚀 ROADMAP - PROCHAINES ÉTAPES

## 📅 PHASE 1 : FONDATIONS (1-2 jours) ✅ TERMINÉ

- [x] Corriger tous les bugs critiques
- [x] Réparer la syntaxe cassée
- [x] Fixer les inputs (WASD)
- [x] Créer un environnement 3D fonctionnel
- [x] Système de sauvegarde (SaveManager)
- [x] Documentation complète

---

## 📅 PHASE 2 : GAMEPLAY DE BASE (3-5 jours)

### 🎯 Objectif : Rendre le jeu jouable et immersif

#### A. Système d'interaction
- [ ] Créer un système "E pour interagir"
- [ ] Raycasting depuis la caméra
- [ ] Feedback visuel (contour sur objet survolé)
- [ ] Interface "Appuyez sur E pour interagir"

#### B. Objets interactifs
- [ ] Téléphone (peut-être déclenche des événements)
- [ ] Porte (ouvre/ferme, change de pièce)
- [ ] Indices (papiers, photos à examiner)
- [ ] Lumières (interrupteurs on/off)

#### C. Menu pause
- [ ] Interface pause sur Échap
- [ ] Boutons : Continuer, Options, Quitter
- [ ] Curseur de souris visible en pause
- [ ] Temps figé pendant la pause

#### D. Audio
- [ ] Sons de pas (différents selon le sol)
- [ ] Sons d'ambiance (horloge, vent)
- [ ] Sons d'interaction (porte, interrupteur)
- [ ] Musique d'ambiance subtile

**Estimation : 15-20 heures**

---

## 📅 PHASE 3 : CONTENU & NARRATION (5-7 jours)

### 🎯 Objectif : Créer une histoire captivante

#### A. Appartement complet
- [ ] Salon (canapé, TV, étagères)
- [ ] Chambre (lit, armoire, bureau)
- [ ] Cuisine (table, frigo, placards)
- [ ] Salle de bain (vraie, avec miroir fonctionnel)
- [ ] Couloir (connexions entre pièces)

#### B. Système de narration
- [ ] Dialogue interne (pensées du joueur)
- [ ] Notes et documents à lire
- [ ] Flashbacks ou souvenirs
- [ ] Objectifs affichés à l'écran

#### C. Histoire
- [ ] Introduction (téléphone qui sonne)
- [ ] Acte 1 : Découverte de l'appartement
- [ ] Acte 2 : Premiers indices
- [ ] Acte 3 : Révélation
- [ ] Conclusion

#### D. Indices et énigmes
- [ ] 5-10 indices cachés dans l'appartement
- [ ] 2-3 énigmes simples à résoudre
- [ ] Journal de l'inspecteur (notes prises)
- [ ] Système de déduction

**Estimation : 25-30 heures**

---

## 📅 PHASE 4 : POLISH & FEATURES (3-5 jours)

### 🎯 Objectif : Peaufiner l'expérience

#### A. Interface utilisateur
- [ ] Inventaire fonctionnel (objets ramassés)
- [ ] Journal d'enquête
- [ ] Carte de l'appartement
- [ ] Objectifs actuels affichés

#### B. Graphismes
- [ ] Textures pour les murs/sols
- [ ] Modèles 3D de meubles
- [ ] Éclairage dynamique et ombres
- [ ] Post-processing (bloom, vignette)

#### C. Animations
- [ ] Animation de marche (balancement)
- [ ] Animation des portes
- [ ] Animation des objets interactifs
- [ ] Transitions entre scènes

#### D. Feedback joueur
- [ ] Tutoriel au début
- [ ] Hints si le joueur est bloqué
- [ ] Système de sauvegarde automatique
- [ ] Paramètres (volume, graphismes)

**Estimation : 15-20 heures**

---

## 📅 PHASE 5 : CONTENU ADDITIONNEL (optionnel)

### 🎯 Objectif : Étendre le jeu

#### A. Plus de lieux
- [ ] Extérieur (balcon, jardin)
- [ ] Cave ou grenier
- [ ] Bureau de police
- [ ] Scène de crime extérieure

#### B. Mécaniques avancées
- [ ] Système de photos (preuves)
- [ ] Interrogatoires (choix de dialogue)
- [ ] Reconstitution de scènes
- [ ] Fin multiple selon les choix

#### C. Rejouabilité
- [ ] Indices aléatoires
- [ ] Différents scénarios
- [ ] Mode difficile
- [ ] Achievements

**Estimation : 30+ heures**

---

## 🎨 SUGGESTIONS CRÉATIVES

### Pour l'atmosphère :
- **Éclairage** : Lumière tamisée, lampes allumables
- **Sons** : Horloge qui tic-tac, pluie dehors
- **Détails** : Photos de famille, journaux datés
- **Mystère** : Objets déplacés, portes ouvertes/fermées

### Pour le gameplay :
- **Déductions** : Relier les indices (tableau d'enquête)
- **Temps limité** : L'inspecteur doit résoudre avant X
- **Choix moraux** : Que faire de certaines preuves ?
- **Red herrings** : Fausses pistes pour tromper

### Pour l'immersion :
- **Narration** : Voix off de l'inspecteur
- **Détails réalistes** : Livres qu'on peut feuilleter
- **Physique** : Objets qu'on peut déplacer
- **Cohérence** : Tout a une raison d'être

---

## 📊 ESTIMATION TOTALE

```
Phase 1 (Fondations)       : ✅ TERMINÉ
Phase 2 (Gameplay)         : 15-20h
Phase 3 (Contenu)          : 25-30h  
Phase 4 (Polish)           : 15-20h
Phase 5 (Additionnel)      : 30h+

TOTAL MVP (Phases 1-4)     : 55-70 heures
TOTAL COMPLET (avec Phase 5) : 85-100 heures
```

---

## 🎯 PRIORITÉS IMMÉDIATES (à faire en premier)

### 1. Système d'interaction (CRITIQUE)
Sans ça, le jeu n'est qu'une balade virtuelle.

```gdscript
# Exemple de base dans Player.gd
func _process(delta):
    if Input.is_action_just_pressed("interact"):
        var raycast = $Camera3D/RayCast3D
        if raycast.is_colliding():
            var obj = raycast.get_collider()
            if obj.has_method("interact"):
                obj.interact()
```

### 2. Au moins 2 objets interactifs
- **Téléphone** : Déclenche un dialogue
- **Porte** : Permet de changer de pièce

### 3. Menu pause fonctionnel
Essentiel pour l'UX.

---

## 💡 CONSEILS

1. **Fais simple d'abord** : MVP avant polish
2. **Teste souvent** : Chaque nouvelle feature
3. **Commits Git réguliers** : Sauvegarde ton travail
4. **Prototype rapide** : Teste les idées en gris/blanc
5. **Écoute les testeurs** : Leur feedback est précieux

---

## 📝 NOTES

- Garde SaveManager pour tout ce qui doit persister
- Utilise des Autoload pour les systèmes globaux
- Organise tes assets (dossiers par type)
- Commente ton code pour plus tard
- Fais des pauses !

---

**Le projet est réparé, maintenant c'est à toi de créer quelque chose de génial ! 🚀**
