extends Area2D

var creation_ui_scene = preload("res://systems/scenes/locations/CreationUI.tscn")
var popup_instance = null

func _ready():
	# CRITIQUE : Activer l'input sur cette Area2D
	input_pickable = true
	
	# Connecter le signal input_event
	input_event.connect(_on_input_event)
	
	print("✓ Mirror ready - Click to create character")
	print("  input_pickable:", input_pickable)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("🖱️ CLICK DETECTED ON MIRROR!")
			_ouvrir_popup()

func _ouvrir_popup():
	if popup_instance != null:
		print("⚠️ Popup already open")
		return
	
	print("📋 Opening character creation...")
	popup_instance = creation_ui_scene.instantiate()
	get_tree().root.add_child(popup_instance)
	popup_instance.popup_centered()
	
	# Nettoyer l'instance quand elle est fermée
	popup_instance.tree_exited.connect(func(): 
		popup_instance = null
		print("✓ Popup closed")
	)

func _input(event):
	# Debug : afficher tous les clics
	if event is InputEventMouseButton and event.pressed:
		print("Mouse click at: ", event.position)
		print("Mirror global position: ", global_position)
