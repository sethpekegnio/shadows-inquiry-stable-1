extends Control

signal back_pressed

@onready var slider_volume_master = $Panel/VBoxContainer/SliderVolumeMaster
@onready var slider_volume_musique = $Panel/VBoxContainer/SliderVolumeMusique
@onready var slider_volume_sfx = $Panel/VBoxContainer/SliderVolumeSFX
@onready var check_fullscreen = $Panel/VBoxContainer/CheckFullscreen
@onready var bouton_retour = $Panel/VBoxContainer/BoutonRetour
@onready var bouton_supprimer_save = $Panel/VBoxContainer/BoutonSupprimerSave

func _ready():
	print("Menu Options ouvert")
	
	# S'assurer que le menu options fonctionne même en pause
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Charger paramètres sauvegardés
	_charger_options()
	
	# Connexions
	if slider_volume_master:
		slider_volume_master.value_changed.connect(_on_volume_master_changed)
	if slider_volume_musique:
		slider_volume_musique.value_changed.connect(_on_volume_musique_changed)
	if slider_volume_sfx:
		slider_volume_sfx.value_changed.connect(_on_volume_sfx_changed)
	if check_fullscreen:
		check_fullscreen.toggled.connect(_on_fullscreen_toggled)
	if bouton_retour:
		bouton_retour.pressed.connect(_retour_menu)
	if bouton_supprimer_save:
		bouton_supprimer_save.pressed.connect(_confirmer_suppression_save)

func _charger_options():
	# Charger depuis fichier config ou valeurs par défaut
	if slider_volume_master:
		slider_volume_master.value = AudioServer.get_bus_volume_db(0)

func _on_volume_master_changed(value: float):
	AudioServer.set_bus_volume_db(0, value)
	print("Volume Master : %.1f dB" % value)

func _on_volume_musique_changed(value: float):
	AudioServer.set_bus_volume_db(1, value)

func _on_volume_sfx_changed(value: float):
	AudioServer.set_bus_volume_db(2, value)

func _on_fullscreen_toggled(actif: bool):
	if actif:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _retour_menu():
	print("Retour au menu")
	back_pressed.emit()
	queue_free()

func _confirmer_suppression_save():
	print("⚠️ ATTENTION : Suppression de la sauvegarde unique !")
	Global.supprimer_sauvegarde()
	print("✓ Sauvegarde supprimée")
	
	# Fermer tous les UI ouverts
	_close_all_ui()
	
	# Fermer ce menu options
	queue_free()
	
	# Retour menu principal
	get_tree().paused = false
	get_tree().change_scene_to_file("res://systems/scenes/locations/MainMenu.tscn")

func _close_all_ui():
	# Fermer carnet, téléphone, etc.
	var root = get_tree().root
	for child in root.get_children():
		if child.name in ["CarnetUI", "TelephoneUI"]:
			child.queue_free()
	
	# Fermer pause menu si ouvert
	var pause_menu = get_tree().current_scene.get_node_or_null("PauseMenu")
	if pause_menu:
		pause_menu.visible = false
