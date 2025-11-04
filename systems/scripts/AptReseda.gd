extends Node3D

var target_position: Vector3 = Vector3.ZERO
var is_moving = false
var move_speed = 3.0
var hovered_object: Node3D = null

func _ready():
	print("=== APT 4B RESEDA LOADED ===")
	
	# Connexion carnet
	Inventory.carnet_opened.connect(_open_carnet)
	
	var player = get_node_or_null("Player")
	if player:
		player.position = Vector3(0, 0, 0)
		print("✓ Player positioned")
	
	var label_info = get_node_or_null("CanvasLayer/LabelInfo")
	if label_info:
		label_info.text = "Apt 4B - 2700 Saticoy St, Reseda\nDetective %s %s" % [
			Global.donnees_joueur.get("first_name", "???"),
			Global.donnees_joueur.get("last_name", "???")
		]
		print("✓ Label info updated")
	
	print("✓ Reseda scene ready")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_handle_click(event.position)

func _handle_click(mouse_pos: Vector2):
	var camera = get_node_or_null("Camera3D")
	if not camera:
		return
	
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.collider
		if collider and collider.is_in_group("interactable"):
			_interact_with_object(collider)
		else:
			_move_to(result.position)

func _interact_with_object(obj: Node3D):
	print("🔧 Interacting with: ", obj.name)
	
	if obj.has_method("_on_interagir"):
		obj._on_interagir()

func _move_to(pos: Vector3):
	var player = get_node_or_null("Player")
	if not player:
		return
	
	target_position = pos
	target_position.y = 0
	is_moving = true
	
	var label = get_node_or_null("CanvasLayer/LabelInteraction")
	if label:
		label.text = "Moving..."

func _process(delta):
	if not is_moving:
		return
	
	var player = get_node_or_null("Player")
	if not player:
		return
	
	var distance = player.global_position.distance_to(target_position)
	
	if distance < 0.2:
		is_moving = false
		var label = get_node_or_null("CanvasLayer/LabelInteraction")
		if label:
			label.text = "Click to move or interact"
	else:
		var direction = (target_position - player.global_position).normalized()
		var movement = direction * move_speed * delta
		
		if movement.length() > distance:
			movement = direction * distance
		
		player.global_position += movement

func _physics_process(_delta):
	var camera = get_node_or_null("Camera3D")
	if not camera:
		return
	
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result and result.collider and result.collider.is_in_group("interactable"):
		if hovered_object != result.collider:
			hovered_object = result.collider
			_on_object_hovered(hovered_object)
	else:
		if hovered_object != null:
			_on_object_unhovered()
			hovered_object = null

func _on_object_hovered(obj: Node3D):
	var label = get_node_or_null("CanvasLayer/LabelInteraction")
	if not label:
		return
	
	match obj.name:
		"ExitDoor":
			label.text = "🚪 EXIT (Click to leave)"
		_:
			label.text = "Click to interact"

func _on_object_unhovered():
	if not is_moving:
		var label = get_node_or_null("CanvasLayer/LabelInteraction")
		if label:
			label.text = "Click to move or interact"

func _open_carnet():
	print("📓 Ouverture carnet depuis Reseda")
	var carnet_scene = load("res://systems/scenes/ui/CarnetUI.tscn")
	var carnet = carnet_scene.instantiate()
	get_tree().root.add_child(carnet)
