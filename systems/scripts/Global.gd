extends Node

# ===== DONNÉES JOUEUR =====
var donnees_joueur = {
	"first_name": "",
	"last_name": "",
	"age": 30,
	"weight": 75,
	"corpulence": 0.0,
	"hair_style": 1,
	"hair_color": "Brown",
	"beard_style": 0,
	"beard_color": "Brown",
	"moustache_style": 0,
	"moustache_color": "Brown",
	"progression": "menu",
	"temps_jeu": 0.0,
	"run_actuel": 1,
	
	# Stats cachées (visibles seulement en fin ou miroirs spéciaux)
	"stats": {
		"Violence": 5,      # Force physique, combat
		"Empathie": 5,      # Convaincre, comprendre PNJ
		"Intuition": 5,     # Détecter indices, mensonges
		"Resilience": 5,    # Survivre blessures, échecs
		"Allies": 5,        # Réseau de contacts
		"Corruption": 0,    # Risque trahison (0-10)
		"SanteMentale": 10, # Baisse avec gore/punitif
		"Reputation": 5,    # Impact enquêtes
		"Ressources": 5,    # Argent, armes
		"Karma": 0          # Choix moraux (-10 à +10)
	},
	
	# Progression narrative
	"enquetes_resolues": [],
	"indices_collectes": [],
	"decisions_morales": [],
	"pnj_rencontres": [],
	"pnj": {},  # FIX: Dictionnaire PNJ initialisé
	"telephone_repondu": false,
	"entretien_termine": false,
	"poste_obtenu": false,
	
	# Punitif
	"cameras_detectees": 0,
	"assassins_survivants": 0,
	"echos_run_precedent": []
}

# ===== CARNET D'ENQUÊTEUR =====
var carnet_data: Array = [""]
var current_page: int = 0

# ===== CHEMIN SAUVEGARDE =====
const CHEMIN_SAVE = "user://sauvegarde_unique.json"

# ===== TIMERS =====
var temps_autosave = 0.0
const INTERVALLE_AUTOSAVE = 30.0

# ===== SIGNAUX =====
signal stat_modifiee(nom_stat: String, ancienne_valeur: int, nouvelle_valeur: int)
signal enquete_resolue(nom_enquete: String)
signal decision_prise(decision: Dictionary)

# ===== INITIALISATION =====
func _ready():
	print("=== GLOBAL SINGLETON INITIALISÉ ===")
	charger_sauvegarde()

func _process(delta):
	# Auto-save permanent
	temps_autosave += delta
	if temps_autosave >= INTERVALLE_AUTOSAVE:
		auto_sauvegarder()
		temps_autosave = 0.0

# ===== GESTION STATS =====
func modifier_stat(nom_stat: String, valeur_changement: int):
	if not donnees_joueur.stats.has(nom_stat):
		push_error("Stat inexistante : " + nom_stat)
		return
	
	var ancienne = donnees_joueur.stats[nom_stat]
	donnees_joueur.stats[nom_stat] += valeur_changement
	
	# Clamp selon stat
	match nom_stat:
		"Corruption", "SanteMentale":
			donnees_joueur.stats[nom_stat] = clamp(donnees_joueur.stats[nom_stat], 0, 10)
		"Karma":
			donnees_joueur.stats[nom_stat] = clamp(donnees_joueur.stats[nom_stat], -10, 10)
		_:
			donnees_joueur.stats[nom_stat] = clamp(donnees_joueur.stats[nom_stat], 0, 10)
	
	var nouvelle = donnees_joueur.stats[nom_stat]
	print("STAT MODIFIÉE : %s (%d → %d)" % [nom_stat, ancienne, nouvelle])
	stat_modifiee.emit(nom_stat, ancienne, nouvelle)

func obtenir_stat(nom_stat: String) -> int:
	return donnees_joueur.stats.get(nom_stat, 0)

# ===== GESTION PROGRESSION =====
func set_progression(nouvelle_progression: String):
	donnees_joueur.progression = nouvelle_progression
	print("Progression mise à jour : ", nouvelle_progression)

func ajouter_enquete_resolue(nom_enquete: String):
	if nom_enquete not in donnees_joueur.enquetes_resolues:
		donnees_joueur.enquetes_resolues.append(nom_enquete)
		enquete_resolue.emit(nom_enquete)
		print("Enquête résolue : ", nom_enquete)

func enregistrer_decision(decision: Dictionary):
	donnees_joueur.decisions_morales.append(decision)
	decision_prise.emit(decision)
	print("Décision enregistrée : ", decision)

# ===== SAUVEGARDE =====
func auto_sauvegarder():
	donnees_joueur.temps_jeu += INTERVALLE_AUTOSAVE
	
	var save_dict = {
		"donnees_joueur": donnees_joueur,
		"carnet_data": carnet_data,
		"current_page": current_page
	}
	
	var fichier = FileAccess.open(CHEMIN_SAVE, FileAccess.WRITE)
	if fichier:
		var json_string = JSON.stringify(save_dict, "\t")
		fichier.store_string(json_string)
		fichier.close()
		print("✓ Auto-save (temps: %.0fs)" % donnees_joueur.temps_jeu)
	else:
		push_error("ERREUR AUTO-SAVE")

func charger_sauvegarde() -> bool:
	if not FileAccess.file_exists(CHEMIN_SAVE):
		print("Aucune sauvegarde trouvée")
		return false
	
	var fichier = FileAccess.open(CHEMIN_SAVE, FileAccess.READ)
	if not fichier:
		push_error("Impossible de lire la sauvegarde")
		return false
	
	var json_text = fichier.get_as_text()
	fichier.close()
	
	var json = JSON.new()
	var result = json.parse(json_text)
	
	if result != OK:
		push_error("Erreur parsing JSON : " + str(json.get_error_message()))
		return false
	
	var loaded_data = json.data
	
	# Charger donnees_joueur
	if loaded_data.has("donnees_joueur"):
		for key in donnees_joueur.keys():
			if loaded_data.donnees_joueur.has(key):
				donnees_joueur[key] = loaded_data.donnees_joueur[key]
	else:
		# Ancien format (rétrocompatibilité)
		for key in donnees_joueur.keys():
			if loaded_data.has(key):
				donnees_joueur[key] = loaded_data[key]
	
	# Charger carnet
	if loaded_data.has("carnet_data"):
		carnet_data = loaded_data.carnet_data
	else:
		carnet_data = [""]
	
	if loaded_data.has("current_page"):
		current_page = loaded_data.current_page
	else:
		current_page = 0
	
	# FIX: Garantir dictionnaire PNJ existe
	if not donnees_joueur.has("pnj") or donnees_joueur.pnj == null:
		donnees_joueur.pnj = {}
		print("✓ Dictionnaire PNJ réinitialisé")
	
	print("✓ Sauvegarde chargée : Run %d, %ds de jeu" % [donnees_joueur.run_actuel, int(donnees_joueur.temps_jeu)])
	return true

func supprimer_sauvegarde():
	if FileAccess.file_exists(CHEMIN_SAVE):
		DirAccess.remove_absolute(CHEMIN_SAVE)
		print("Sauvegarde supprimée")

func nouvelle_partie():
	supprimer_sauvegarde()
	var ancien_run = donnees_joueur.run_actuel
	
	donnees_joueur = {
		"first_name": "",
		"last_name": "",
		"age": 30,
		"weight": 75,
		"corpulence": 0.0,
		"hair_style": 1,
		"hair_color": "Brown",
		"beard_style": 0,
		"beard_color": "Brown",
		"moustache_style": 0,
		"moustache_color": "Brown",
		"progression": "creation_perso",
		"temps_jeu": 0.0,
		"run_actuel": ancien_run + 1,
		"stats": {
			"Violence": 5, "Empathie": 5, "Intuition": 5,
			"Resilience": 5, "Allies": 5, "Corruption": 0,
			"SanteMentale": 10, "Reputation": 5, "Ressources": 5, "Karma": 0
		},
		"enquetes_resolues": [], "indices_collectes": [], "decisions_morales": [],
		"pnj_rencontres": [], 
		"pnj": {},
		"telephone_repondu": false,
		"entretien_termine": false, "poste_obtenu": false,
		"cameras_detectees": 0, "assassins_survivants": 0, "echos_run_precedent": []
	}
	
	# Reset carnet
	carnet_data = [""]
	current_page = 0
	
	print("=== NOUVELLE PARTIE : RUN %d ===" % donnees_joueur.run_actuel)
	print("📓 Carnet réinitialisé")

# ===== CALCUL SCORE FINAL =====
func calculer_score_final() -> Dictionary:
	var score = {
		"total": 0,
		"enquetes": len(donnees_joueur.enquetes_resolues) * 100,
		"survie": donnees_joueur.stats.SanteMentale * 50,
		"reputation": donnees_joueur.stats.Reputation * 30,
		"karma_bonus": abs(donnees_joueur.stats.Karma) * 20,
		"temps_survie": int(donnees_joueur.temps_jeu / 60)
	}
	score.total = score.enquetes + score.survie + score.reputation + score.karma_bonus + score.temps_survie
	return score
