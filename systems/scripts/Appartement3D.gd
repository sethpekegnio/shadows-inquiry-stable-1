# res://systems/scripts/Appartement3D.gd (chunk 1/6)
extends Node3D

var donnees_save = {}

@onready var camera = $Camera3D
@onready var player = $Player
@onready var label_info = $CanvasLayer/LabelInfo
@onready var label_interaction = $CanvasLayer/LabelInteraction

# UI
var action_menu_scene = preload("res://systems/scenes/ui/ActionMenu.tscn")
var action_menu_instance = null

# Déplacement
var target_position: Vector3 = Vector3.ZERO
var is_moving = false
var move_speed = 3.0

# Interaction
var hovered_object: Node3D = null

# Objet tenu en main
var held_item: Dictionary = {}
var held_item_visual: Node3D = null# res://systems/scripts/Appartement3D.gd (chunk 2/6)

func _ready():
	print("=== APARTMENT 3D - AVEC ACTIONS ===")
	
	# Arrêter la musique du menu si elle existe
	var menu_music = get_tree().root.get_node_or_null("MenuMusicPersistent")
	if menu_music:
		print("🎵 Arrêt musique menu")
		menu_music.queue_free()
	
	# Charger données
	donnees_save = Global.donnees_joueur
	_update_character_info()
	Global.set_progression("appartement_debut")
	
	# Sélectionner la main par défaut dans l'inventaire
	Inventory.select_slot(0)
	
	# Connexions
	Inventory.carnet_opened.connect(_open_carnet)
	Inventory.held_item_changed.connect(_on_held_item_changed)
	
	# Positionner le joueur
	if player:
		player.position = Vector3(0, 0, 0)
		print("👤 Player positioned at: %s" % player.position)
	else:
		print("⚠️ WARNING: Player node not found!")
	
	print("✓ Apartment ready - Click to move, hold item + click for actions")
	
	if label_interaction:
		label_interaction.text = "Click to move | Keys 1-9,0 for items"

func _update_character_info():
	if label_info:
		label_info.text = "Detective %s %s\nAge: %d | Weight: %d kg\nApartment" % [
			donnees_save.get("first_name", "Unknown"),
			donnees_save.get("last_name", "Unknown"),
			donnees_save.get("age", 30),
			donnees_save.get("weight", 75)
		]# res://systems/scripts/Appartement3D.gd (chunk 3/6)

func _on_held_item_changed(item: Dictionary):
	held_item = item
	
	# Détruire ancien visuel
	if held_item_visual:
		held_item_visual.queue_free()
		held_item_visual = null
	
	# Créer visuel 3D de l'objet tenu (simple mesh pour l'instant)
	if not held_item.is_empty() and player:
		held_item_visual = _create_held_item_visual(held_item)
		if held_item_visual and player.has_node("Hand"):
			player.get_node("Hand").add_child(held_item_visual)
		elif held_item_visual:
			player.add_child(held_item_visual)
			held_item_visual.position = Vector3(0.3, 1.2, 0.5)  # Devant le joueur

func _create_held_item_visual(item: Dictionary) -> Node3D:
	# Créer un simple mesh pour représenter l'objet
	var mesh_instance = MeshInstance3D.new()
	
	# Choisir forme selon catégorie
	var category = item.get("category", "misc")
	match category:
		"weapon":
			if "knife" in item.get("id", "").to_lower():
				mesh_instance.mesh = BoxMesh.new()
				mesh_instance.mesh.size = Vector3(0.05, 0.3, 0.02)
			elif "pistol" in item.get("id", "").to_lower() or "gun" in item.get("id", "").to_lower():
				mesh_instance.mesh = BoxMesh.new()
				mesh_instance.mesh.size = Vector3(0.15, 0.12, 0.05)
			else:
				mesh_instance.mesh = CapsuleMesh.new()
				mesh_instance.mesh.radius = 0.03
				mesh_instance.mesh.height = 0.4
		"tool":
			mesh_instance.mesh = BoxMesh.new()
			mesh_instance.mesh.size = Vector3(0.08, 0.2, 0.03)
		_:
			mesh_instance.mesh = SphereMesh.new()
			mesh_instance.mesh.radius = 0.08
	
	# Matériau coloré selon catégorie
	var material = StandardMaterial3D.new()
	match category:
		"weapon": material.albedo_color = Color(0.7, 0.1, 0.1)  # Rouge
		"chemical": material.albedo_color = Color(0.2, 0.8, 0.2)  # Vert
		"tool": material.albedo_color = Color(0.6, 0.6, 0.6)  # Gris
		"equipment": material.albedo_color = Color(0.2, 0.4, 0.8)  # Bleu
		"tech": material.albedo_color = Color(0.8, 0.8, 0.2)  # Jaune
		"medical": material.albedo_color = Color(0.9, 0.9, 0.9)  # Blanc
		_: material.albedo_color = Color(0.5, 0.3, 0.1)  # Marron
	
	mesh_instance.set_surface_override_material(0, material)
	
	return mesh_instance# res://systems/scripts/Appartement3D.gd (chunk 4/6)

func _input(event):
	# Sélection rapide inventaire (touches 1-9 = slots 0-8, touche 0 = slot 9)
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode >= KEY_1 and keycode <= KEY_9:
			var slot = keycode - KEY_1  # Touche 1 → slot 0
			Inventory.select_slot(slot)
			get_viewport().set_input_as_handled()
			return
		elif keycode == KEY_0:
			Inventory.select_slot(9)  # Touche 0 → slot 9
			get_viewport().set_input_as_handled()
			return
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_handle_left_click(event.position)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_handle_right_click(event.position)

func _handle_left_click(mouse_pos: Vector2):
	# Raycast
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.collider
		
		# Si on a un objet en main, ouvrir menu d'actions
		if not held_item.is_empty():
			_show_action_menu(collider)
		elif collider.is_in_group("interactable"):
			_interact_with_object(collider)
		else:
			_move_to(result.position)

func _handle_right_click(mouse_pos: Vector2):
	# Clic droit = toujours déplacement
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		_move_to(result.position)

func _show_action_menu(target):
	print("📋 Ouverture menu actions : %s sur %s" % [held_item.name, target.name if target else "sol"])
	
	# Fermer ancien menu
	if action_menu_instance:
		action_menu_instance.queue_free()
	
	# Créer nouveau menu
	action_menu_instance = action_menu_scene.instantiate()
	get_tree().root.add_child(action_menu_instance)
	
	# Connexion signal
	action_menu_instance.action_selected.connect(_on_action_executed)
	
	# Afficher avec item et cible
	action_menu_instance.show_actions(held_item, target)

func _on_action_executed(action: String, target):
	print("✅ Action exécutée : %s avec %s sur %s" % [
		action,
		held_item.name,
		target.name if target else "soi-même"
	])
	
	# Traiter l'action selon le type
	_process_action(action, held_item, target)

func _process_action(action: String, item: Dictionary, target):
	# TODO: Implémenter les conséquences réelles des actions
	# Pour l'instant, juste afficher un message
	
	var message = "🎬 %s : %s" % [action, item.name]
	
	if target and target is CharacterBody3D:
		message += " sur PNJ"
		# Exemple: Si "Poignarder", le PNJ meurt
		if "poignard" in action.to_lower() or "tuer" in action.to_lower():
			message += " → MORT"
			# target.die()
	elif target:
		message += " sur %s" % target.name
	else:
		message += " sur soi-même"
	
	if label_interaction:
		label_interaction.text = message
	
	# Modifier stats selon action
	if "menacer" in action.to_lower() or "intimidid" in action.to_lower():
		Global.modifier_stat("Violence", 1)
	elif "soigner" in action.to_lower() or "aider" in action.to_lower():
		Global.modifier_stat("Empathie", 1)
	elif "analyser" in action.to_lower() or "examiner" in action.to_lower():
		Global.modifier_stat("Intuition", 1)
	
	# Réinitialiser après 3 secondes
	await get_tree().create_timer(3.0).timeout
	if label_interaction:
		label_interaction.text = "Click to move or interact"# res://systems/scripts/Appartement3D.gd (chunk 5/6)

func _move_to(pos: Vector3):
	if not player:
		print("⚠️ Cannot move: No player")
		return
	
	target_position = pos
	target_position.y = 0
	is_moving = true
	
	if label_interaction:
		label_interaction.text = "Moving..."
	
	# Si le joueur a une méthode move_to
	if player.has_method("move_to"):
		player.move_to(target_position)

func _interact_with_object(obj: Node3D):
	print("🔧 Interacting with: ", obj.name)
	
	match obj.name:
		"Telephone":
			print("📞 Telephone interaction")
			if obj.has_method("_on_interagir"):
				obj._on_interagir()
		"Door", "Porte":
			print("🚪 Door interaction")
			if obj.has_method("_on_interagir"):
				obj._on_interagir()
		_:
			if label_interaction:
				label_interaction.text = "Nothing special"

func _process(delta):
	if not player:
		return
	
	# Mouvement simple
	if is_moving:
		var distance = player.global_position.distance_to(target_position)
		
		if distance < 0.2:
			is_moving = false
			if label_interaction:
				if held_item.is_empty():
					label_interaction.text = "Click to move or interact"
				else:
					label_interaction.text = "Click to use: %s" % held_item.name
		else:
			var direction = (target_position - player.global_position).normalized()
			var movement = direction * move_speed * delta
			
			if movement.length() > distance:
				movement = direction * distance
			
			player.global_position += movement# res://systems/scripts/Appartement3D.gd (chunk 6/6)

func _physics_process(_delta):
	if not camera:
		return
	
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result and result.collider.is_in_group("interactable"):
		if hovered_object != result.collider:
			hovered_object = result.collider
			_on_object_hovered(hovered_object)
	else:
		if hovered_object != null:
			_on_object_unhovered()
			hovered_object = null

func _on_object_hovered(obj: Node3D):
	if not label_interaction:
		return
	
	if not held_item.is_empty():
		label_interaction.text = "Click to use %s on %s" % [held_item.name, obj.name]
	else:
		match obj.name:
			"Telephone": 
				label_interaction.text = "📞 Phone (E to interact)"
			"Door", "Porte": 
				label_interaction.text = "🚪 Exit (E to interact)"
			_: 
				label_interaction.text = "Click to interact"

func _on_object_unhovered():
	if not is_moving and label_interaction:
		if held_item.is_empty():
			label_interaction.text = "Click to move or interact"
		else:
			label_interaction.text = "Click to use: %s" % held_item.name

func _open_carnet():
	print("📓 Ouverture carnet depuis inventaire")
	var carnet_scene = load("res://systems/scenes/ui/CarnetUI.tscn")
	var carnet = carnet_scene.instantiate()
	get_tree().root.add_child(carnet)
