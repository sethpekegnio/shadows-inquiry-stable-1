# res://systems/scripts/PauseMenu.gd
extends CanvasLayer

# ===== RÉFÉRENCES =====
@onready var btn_resume = $CenterContainer/VBoxContainer/BtnResume
@onready var btn_options = $CenterContainer/VBoxContainer/BtnOptions
@onready var btn_main_menu = $CenterContainer/VBoxContainer/BtnMainMenu
@onready var btn_quit = $CenterContainer/VBoxContainer/BtnQuit

var options_scene = preload("res://systems/scenes/locations/OptionsMenu.tscn")
var options_instance = null

# ===== INITIALISATION =====
func _ready():
	# Cacher par défaut
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  # Continue en pause
	
	# Connexions
	btn_resume.pressed.connect(_on_resume)
	btn_options.pressed.connect(_on_options)
	btn_main_menu.pressed.connect(_on_main_menu)
	btn_quit.pressed.connect(_on_quit)
	
	print("✓ PauseMenu prêt")

# ===== INPUT =====
func _input(event):
	if event.is_action_pressed("pause"):
		_toggle_pause()
		get_viewport().set_input_as_handled()

# ===== GESTION PAUSE =====
func _toggle_pause():
	var is_paused = get_tree().paused
	get_tree().paused = not is_paused
	visible = not is_paused
	
	if visible:
		print("→ Jeu en pause")
	else:
		print("→ Jeu repris")

# ===== BOUTONS =====
func _on_resume():
	print("Resume")
	_toggle_pause()

func _on_options():
	print("Options (depuis pause)")
	
	if options_instance:
		return
	
	# Cacher le pause menu temporairement
	visible = false
	
	options_instance = options_scene.instantiate()
	get_tree().root.add_child(options_instance)
	
	# Quand les options se ferment, réafficher le pause menu
	options_instance.tree_exited.connect(func(): 
		options_instance = null
		visible = true
	)

func _on_main_menu():
	print("→ Retour menu principal")
	
	# Sauvegarder avant quitter
	Global.auto_sauvegarder()
	
	# Fermer tous les popups et UI ouverts
	_close_all_ui()
	
	# Désactiver pause
	get_tree().paused = false
	
	# Retour menu
	get_tree().change_scene_to_file("res://systems/scenes/locations/MainMenu.tscn")

func _close_all_ui():
	# Fermer carnet si ouvert
	var root = get_tree().root
	for child in root.get_children():
		if child.name == "CarnetUI":
			child.queue_free()
		if child.name == "TelephoneUI":
			child.queue_free()
	
	# Fermer options si ouvertes
	if options_instance:
		options_instance.queue_free()
		options_instance = null

func _on_quit():
	print("→ Quitter le jeu")
	
	# Sauvegarder
	Global.auto_sauvegarder()
	
	# Quitter
	get_tree().quit()
