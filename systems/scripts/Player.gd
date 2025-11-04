extends CharacterBody3D

@export var walk_speed = 2.5
@export var run_speed = 5.0
@export var rotation_speed = 12.0

var current_speed = 2.5
var target_position: Vector3
var is_moving_to_target = false

@onready var model = $KenneyModel
var animation_player = null

signal reached_destination

func _ready():
	print("=== PLAYER READY ===")
	current_speed = walk_speed
	
	# DEBUGGER COMPLET : Lister toute la structure
	print("\n=== STRUCTURE DU MODÈLE ===")
	debug_print_tree(model, 0)
	print("=== FIN STRUCTURE ===\n")
	
	# Chercher l'AnimationPlayer
	animation_player = find_animation_player(model)
	
	if animation_player:
		print("✓ Found AnimationPlayer at: ", animation_player.get_path())
		var anims = animation_player.get_animation_list()
		print("  Available animations: ", anims)
		
		# Essayer toutes les animations disponibles
		if anims.size() > 0:
			var first_anim = anims[0]
			print("  Trying to play: ", first_anim)
			animation_player.play(first_anim)
			print("  Is playing: ", animation_player.is_playing())
			print("  Current animation: ", animation_player.current_animation)
	else:
		print("❌ No AnimationPlayer found!")
	
	# Chercher les mesh pour appliquer la texture
	print("\n=== RECHERCHE DES MESH ===")
	find_and_apply_material(model)

func debug_print_tree(node: Node, indent: int) -> void:
	var spaces = ""
	for i in range(indent):
		spaces += "  "
	
	var type_name = node.get_class()
	print(spaces, "- ", node.name, " (", type_name, ")")
	
	# Si c'est un MeshInstance3D, afficher les infos du matériau
	if node is MeshInstance3D:
		print(spaces, "  └─ MESH FOUND! Surface count: ", node.get_surface_override_material_count())
	
	for child in node.get_children():
		debug_print_tree(child, indent + 1)

func find_and_apply_material(node: Node) -> void:
	if node is MeshInstance3D:
		print("  Found MeshInstance3D: ", node.name)
		var mat = load("res://addons/kenney_animated-characters-2/Skins/criminalMaleA.png")
		if mat:
			var material = StandardMaterial3D.new()
			material.albedo_texture = mat
			material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
			node.set_surface_override_material(0, material)
			print("    ✓ Applied material to surface 0")
	
	for child in node.get_children():
		find_and_apply_material(child)

func find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	
	for child in node.get_children():
		if child is AnimationPlayer:
			return child
		var result = find_animation_player(child)
		if result:
			return result
	
	return null

func move_to(pos: Vector3) -> void:
	target_position = pos
	target_position.y = position.y
	is_moving_to_target = true
	
	if animation_player and animation_player.get_animation_list().size() > 0:
		var anims = animation_player.get_animation_list()
		# Chercher une animation de run/walk
		for anim in anims:
			if "run" in anim.to_lower() or "walk" in anim.to_lower():
				animation_player.play(anim)
				print("  Playing: ", anim)
				return
		# Sinon jouer la première animation
		animation_player.play(anims[0])

func stop_moving():
	is_moving_to_target = false
	velocity = Vector3.ZERO
	
	if animation_player and animation_player.get_animation_list().size() > 0:
		var anims = animation_player.get_animation_list()
		for anim in anims:
			if "idle" in anim.to_lower():
				animation_player.play(anim)
				return
	
	reached_destination.emit()

func set_run_mode(running: bool):
	if running:
		current_speed = run_speed
	else:
		current_speed = walk_speed

func _physics_process(delta):
	if is_moving_to_target:
		var direction = (target_position - global_position)
		direction.y = 0
		var distance = direction.length()
		
		if distance < 0.15:
			stop_moving()
			return
		
		direction = direction.normalized()
		
		if direction.length() > 0.01:
			var target_rotation = atan2(direction.x, direction.z)
			rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)
		
		velocity = direction * current_speed
		move_and_slide()

func _input(event):
	if is_moving_to_target and event is InputEventKey:
		if event.keycode == KEY_SHIFT:
			set_run_mode(event.pressed)
