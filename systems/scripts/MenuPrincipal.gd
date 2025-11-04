extends Node2D

# ===== RÉFÉRENCES =====
@onready var button_play = $Node2D/VBoxContainer/ButtonPlay
@onready var button_options = $Node2D/VBoxContainer/ButtonOptions
@onready var button_quit = $Node2D/VBoxContainer/ButtonQuit
@onready var button_carnet = $Node2D/ButtonCarnet
@onready var menu_music = $Node2D/MenuMusic

var options_scene = preload("res://systems/scenes/locations/OptionsMenu.tscn")
var carnet_scene = preload("res://systems/scenes/ui/CarnetUI.tscn")
var options_instance = null

# ===== INITIALISATION =====
func _ready():
	# Vérifier si musique persistante existe déjà
	var persistent_music = get_tree().root.get_node_or_null("MenuMusicPersistent")
	
	if persistent_music:
		# La musique existe déjà (retour depuis jeu)
		print("🎵 Musique persistante trouvée, réutilisation")
		# La rattacher à cette scène
		get_tree().root.remove_child(persistent_music)
		$Node2D.add_child(persistent_music)
		persistent_music.name = "MenuMusic"
		menu_music = persistent_music
	elif menu_music and not menu_music.playing:
		# Première ouverture, démarrer la musique
		menu_music.play()
	
	# Vérification boutons
	if button_play == null:
		push_error("ButtonPlay introuvable !")
		return
	
	# Configuration bouton selon sauvegarde
	if FileAccess.file_exists(Global.CHEMIN_SAVE):
		button_play.text = "Continue"
	else:
		button_play.text = "New Game"
	
	# Connexions
	button_play.pressed.connect(_on_play_pressed)
	if button_options:
		button_options.pressed.connect(_on_options_pressed)
	if button_quit:
		button_quit.pressed.connect(_on_quit_pressed)
	if button_carnet:
		button_carnet.pressed.connect(_on_carnet_pressed)
	
	print("=== MENU PRINCIPAL ===")

# ===== BOUTONS =====
func _on_play_pressed():
	print("Play/Continue button clicked")
	
	# Si sauvegarde existe, charger et reprendre
	if FileAccess.file_exists(Global.CHEMIN_SAVE):
		var chargement_ok = Global.charger_sauvegarde()
		
		if chargement_ok:
			var progression = Global.donnees_joueur.get("progression", "")
			print("Progression chargée: ", progression)
			
			# FIX: Toujours aller à l'appartement si progression contient "appartement"
			if "appartement" in progression:
				print("→ Appartement 3D (Continue)")
				get_tree().change_scene_to_file("res://systems/scenes/locations/Appartement3D.tscn")
			elif progression == "menu" or progression == "creation_perso" or progression == "":
				print("→ Character Creation")
				get_tree().change_scene_to_file("res://systems/scenes/locations/CharacterCreation.tscn")
			elif "commissariat" in progression:
				print("→ Commissariat")
				get_tree().change_scene_to_file("res://systems/scenes/locations/Commissariat.tscn")
			else:
				print("⚠️ Progression inconnue: %s, démarrage appartement" % progression)
				get_tree().change_scene_to_file("res://systems/scenes/locations/Appartement3D.tscn")
		else:
			# Erreur chargement
			print("Erreur chargement save, nouvelle partie")
			_nouvelle_partie()
	else:
		# Pas de save
		_nouvelle_partie()

func _nouvelle_partie():
	print("→ Nouvelle partie")
	Global.nouvelle_partie()
	
	# Garder la musique en mode persistant
	if menu_music and menu_music.playing:
		# Détacher de la scène actuelle et ajouter à root
		var parent = menu_music.get_parent()
		if parent:
			parent.remove_child(menu_music)
		get_tree().root.add_child(menu_music)
		menu_music.name = "MenuMusicPersistent"
		print("🎵 Musique persistante activée")
	
	get_tree().change_scene_to_file("res://systems/scenes/locations/CharacterCreation.tscn")

func _on_options_pressed():
	print("Options menu")
	
	if options_instance:
		return
	
	options_instance = options_scene.instantiate()
	get_tree().root.add_child(options_instance)
	options_instance.tree_exited.connect(func(): options_instance = null)

func _on_quit_pressed():
	print("Quitting game")
	get_tree().quit()

func _on_carnet_pressed():
	print("📓 Ouverture carnet depuis menu")
	var carnet = carnet_scene.instantiate()
	get_tree().root.add_child(carnet)
