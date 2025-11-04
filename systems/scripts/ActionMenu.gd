# res://systems/scripts/ActionMenu.gd
extends PopupPanel

signal action_selected(action: String, target)

var current_item: Dictionary = {}
var current_target = null
var action_buttons = []

func _ready():
	size = Vector2i(300, 400)

func show_actions(item: Dictionary, target = null):
	current_item = item
	current_target = target
	
	# Nettoyer anciens boutons
	for btn in action_buttons:
		if btn:
			btn.queue_free()
	action_buttons.clear()
	
	# Créer conteneur si nécessaire
	var container = get_node_or_null("VBoxContainer")
	if not container:
		container = VBoxContainer.new()
		container.name = "VBoxContainer"
		container.set_anchors_preset(Control.PRESET_FULL_RECT)
		container.offset_left = 10
		container.offset_top = 10
		container.offset_right = -10
		container.offset_bottom = -10
		add_child(container)
	
	# Clear container
	for child in container.get_children():
		child.queue_free()
	
	# Titre avec objet
	var title_label = Label.new()
	title_label.text = "%s %s" % [item.get("icon", ""), item.get("name", "Item")]
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 18)
	container.add_child(title_label)
	
	var sep = HSeparator.new()
	container.add_child(sep)
	
	# Sous-titre avec cible
	if target:
		var target_label = Label.new()
		target_label.text = "Sur : %s" % _get_target_name(target)
		target_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		target_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
		container.add_child(target_label)
		
		var sep2 = HSeparator.new()
		container.add_child(sep2)
	
	# Déterminer les actions disponibles
	var actions = _get_available_actions(item, target)
	
	if actions.size() == 0:
		var no_action = Label.new()
		no_action.text = "Aucune action disponible"
		no_action.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(no_action)
	else:
		# Créer boutons d'actions
		for action in actions:
			var btn = Button.new()
			btn.text = action
			btn.custom_minimum_size = Vector2(0, 45)
			btn.pressed.connect(_on_action_clicked.bind(action))
			container.add_child(btn)
			action_buttons.append(btn)
	
	# Bouton annuler
	var sep3 = HSeparator.new()
	container.add_child(sep3)
	
	var btn_cancel = Button.new()
	btn_cancel.text = "Annuler"
	btn_cancel.custom_minimum_size = Vector2(0, 40)
	btn_cancel.pressed.connect(hide)
	container.add_child(btn_cancel)
	
	# Afficher popup centré
	popup_centered()

func _get_available_actions(item: Dictionary, target) -> Array:
	if not item.has("actions"):
		return []
	
	var actions = item.actions
	
	# Si actions est un dictionnaire (actions contextuelles)
	if typeof(actions) == TYPE_DICTIONARY:
		if target == null:
			# Sur soi-même
			return actions.get("on_self", [])
		elif target is CharacterBody3D or target.is_in_group("pnj"):
			# Sur PNJ
			return actions.get("on_pnj", [])
		else:
			# Sur objet
			return actions.get("on_object", [])
	
	# Sinon array simple (ancien format)
	elif typeof(actions) == TYPE_ARRAY:
		return actions
	
	return []

func _get_target_name(target) -> String:
	if target == null:
		return "Soi-même"
	
	if target is CharacterBody3D:
		# PNJ avec données
		if target.has_method("get_pnj_name"):
			return target.get_pnj_name()
		return "Personne"
	
	if target is Node3D:
		return target.name
	
	return "Objet"

func _on_action_clicked(action: String):
	print("🎬 Action : %s avec %s sur %s" % [action, current_item.name, _get_target_name(current_target)])
	action_selected.emit(action, current_target)
	hide()
