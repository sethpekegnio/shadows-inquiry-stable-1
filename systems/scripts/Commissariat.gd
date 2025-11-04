extends Node3D

const PNJDatabase = preload("res://systems/scripts/PNJDatabase.gd")

var pnj_scene = preload("res://systems/scenes/locations/PNJ.tscn")

@onready var camera = $Camera3D
@onready var player = $Player
@onready var label_info = $CanvasLayer/LabelInfo
@onready var label_interaction = $CanvasLayer/LabelInteraction

# Déplacement
var target_position: Vector3 = Vector3.ZERO
var is_moving = false
var move_speed = 3.0

# Interaction
var hovered_object: Node3D = null

func _ready():
	print("=== COMMISSARIAT READY ===")
	
	# Vérifier si entretien nécessaire
	if not Global.donnees_joueur.get("entretien_termine", false):
		print("🎤 Premier passage : Entretien d'embauche")
		get_tree().change_scene_to_file("res://systems/scenes/locations/EntretienEmbauche.tscn")
		return
	
	# Générer et spawn PNJ
	generate_and_spawn_pnj()
	
	# Connexion carnet
	Inventory.carnet_opened.connect(_open_carnet)
	
	# Positionner le joueur
	if player:
		player.position = Vector3(0, 0, 0)
		print("👤 Player positioned at: %s" % player.position)
	
	# Info label
	if label_info:
		label_info.text = "Police Precinct\nDetective %s %s" % [
			Global.donnees_joueur.get("first_name", "Unknown"),
			Global.donnees_joueur.get("last_name", "Unknown")
		]
	
	if label_interaction:
		label_interaction.text = "Click to move or interact"

func generate_and_spawn_pnj():
	# Trouver les positions
	var directeur_pos = find_child("DirecteurPosition", true, false)
	var reception_pos = find_child("ReceptionPosition", true, false)
	
	if directeur_pos == null:
		print("⚠️ DirecteurPosition introuvable, création à l'origine")
		directeur_pos = Node3D.new()
		directeur_pos.name = "DirecteurPosition"
		directeur_pos.position = Vector3(5, 0, 0)
		add_child(directeur_pos)
	
	if reception_pos == null:
		print("⚠️ ReceptionPosition introuvable, création à l'origine")
		reception_pos = Node3D.new()
		reception_pos.name = "ReceptionPosition"
		reception_pos.position = Vector3(-5, 0, 0)
		add_child(reception_pos)
	
	# Créer ou charger PNJ
	if not Global.donnees_joueur.has("pnj") or Global.donnees_joueur.pnj.is_empty():
		print("🎲 Création nouveaux PNJ")
		
		var dir_data = PNJDatabase.generer("directeur")
		var rec_data = PNJDatabase.generer("reception")
		
		Global.donnees_joueur.pnj = {
			"directeur": dir_data,
			"reception": rec_data
		}
		
		Global.auto_sauvegarder()
	
	# Spawn les PNJ
	spawn_pnj(Global.donnees_joueur.pnj.directeur, directeur_pos)
	spawn_pnj(Global.donnees_joueur.pnj.reception, reception_pos)

func spawn_pnj(pnj_data: Dictionary, position_node: Node3D):
	if pnj_data.is_empty():
		print("⚠️ PNJ data vide, skip")
		return
	
	print("👤 Spawn PNJ : %s %s" % [pnj_data.get("prenom", "???"), pnj_data.get("nom", "???")])
	
	var pnj_instance = pnj_scene.instantiate()
	pnj_instance.data = pnj_data
	position_node.add_child(pnj_instance)
	pnj_instance.position = Vector3.ZERO
	
	print("  ✓ Spawné à : %s" % position_node.name)

# ===== DÉPLACEMENT ET INTERACTION (copié depuis Appartement3D) =====

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_handle_left_click(event.position)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_handle_right_click(event.position)

func _handle_left_click(mouse_pos: Vector2):
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.collider
		
		if collider.is_in_group("interactable"):
			_interact_with_object(collider)
		else:
			_move_to(result.position)

func _handle_right_click(mouse_pos: Vector2):
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		_move_to(result.position)

func _move_to(pos: Vector3):
	if not player:
		return
	
	target_position = pos
	target_position.y = 0
	is_moving = true
	
	if label_interaction:
		label_interaction.text = "Moving..."
	
	if player.has_method("move_to"):
		player.move_to(target_position)

func _interact_with_object(obj: Node3D):
	print("🔧 Interacting with: ", obj.name)
	
	match obj.name:
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
	
	if is_moving:
		var distance = player.global_position.distance_to(target_position)
		
		if distance < 0.2:
			is_moving = false
			if label_interaction:
				label_interaction.text = "Click to move or interact"
		else:
			var direction = (target_position - player.global_position).normalized()
			var movement = direction * move_speed * delta
			
			if movement.length() > distance:
				movement = direction * distance
			
			player.global_position += movement

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
	
	match obj.name:
		"Door", "Porte": 
			label_interaction.text = "🚪 Exit (E to interact)"
		_: 
			label_interaction.text = "Click to interact"

func _on_object_unhovered():
	if not is_moving and label_interaction:
		label_interaction.text = "Click to move or interact"

func _open_carnet():
	print("📓 Ouverture carnet depuis inventaire")
	var carnet_scene = load("res://systems/scenes/ui/CarnetUI.tscn")
	var carnet = carnet_scene.instantiate()
	get_tree().root.add_child(carnet)
