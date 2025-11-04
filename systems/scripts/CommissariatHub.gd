extends Node3D

# ===== HUB COMMISSARIAT =====

@onready var player = $Player
@onready var label_info = $CanvasLayer/LabelInfo
@onready var label_interaction = $CanvasLayer/LabelInteraction
@onready var panel_enquetes = $CanvasLayer/PanelEnquetes

var raycast: RayCast3D
var objet_proche: Node3D = null

func _ready():
	print("=== PRECINCT HUB ===")
	
	if label_info:
		label_info.text = "Central Precinct\nDetective %s, %d years old" % [
			Global.donnees_joueur.sexe,
			Global.donnees_joueur.age
		]
	
	_setup_raycast()
	
	if panel_enquetes:
		panel_enquetes.visible = false

func _setup_raycast():
	raycast = RayCast3D.new()
	player.add_child(raycast)
	raycast.target_position = Vector3(0, 0, -2)
	raycast.enabled = true

func _process(_delta):
	_detecter_objets()
	
	if Input.is_action_just_pressed("interact") and objet_proche:
		_interagir()

func _detecter_objets():
	if not raycast or not raycast.is_colliding():
		_cacher_prompt()
		objet_proche = null
		return
	
	var collider = raycast.get_collider()
	if collider:
		if objet_proche != collider:
			objet_proche = collider
			_afficher_prompt(collider.name)
	else:
		_cacher_prompt()
		objet_proche = null

func _interagir():
	if not objet_proche:
		return
	
	var nom = objet_proche.name
	print("Interaction: ", nom)
	
	match nom:
		"BoardEnquetes":
			_ouvrir_panel_enquetes()
		"BureauJoueur":
			print("📁 Your desk - Not yet implemented")
		_:
			print("Object not interactive")

func _afficher_prompt(nom: String):
	if label_interaction:
		label_interaction.visible = true
		label_interaction.text = "[E] %s" % nom

func _cacher_prompt():
	if label_interaction:
		label_interaction.visible = false

func _ouvrir_panel_enquetes():
	print("📋 Opening Investigations Board")
	
	if not panel_enquetes:
		return
	
	panel_enquetes.visible = true
	
	# Message temporaire
	var vbox = panel_enquetes.get_node("VBoxContainer")
	if vbox:
		var label = Label.new()
		label.text = "No investigations available yet.\n\n(Coming soon: Investigation system)"
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(label)
		
		var btn_close = Button.new()
		btn_close.text = "Close"
		btn_close.pressed.connect(func(): panel_enquetes.visible = false)
		vbox.add_child(btn_close)
