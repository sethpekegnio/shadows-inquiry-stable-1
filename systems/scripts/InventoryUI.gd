extends CanvasLayer

var slot_panels = []

func _ready():
	print("=== INVENTORY UI READY ===")
	
	# Récupérer tous les slots
	for i in range(10):
		var slot = get_node("Panel/HBoxSlots/Slot%d" % i)
		slot_panels.append(slot)
		
		# Ajouter un style de bordure par défaut
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.15, 0.15, 0.2, 0.9)
		style_box.set_border_width_all(2)  # FIX: Utiliser set_border_width_all()
		style_box.border_color = Color(0.4, 0.4, 0.5)
		style_box.set_corner_radius_all(5)  # FIX: Utiliser set_corner_radius_all()
		slot.add_theme_stylebox_override("panel", style_box)
	
	# Connexions signaux
	Inventory.item_added.connect(_on_item_added)
	Inventory.item_removed.connect(_on_item_removed)
	Inventory.slot_selected.connect(_on_slot_selected)
	
	# Update initial
	_refresh_all()

func _input(event):
	if event is InputEventKey and event.pressed:
		# Raccourcis 1-0
		var key_code = event.keycode
		var slot = -1
		
		match key_code:
			KEY_1: slot = 0
			KEY_2: slot = 1
			KEY_3: slot = 2
			KEY_4: slot = 3
			KEY_5: slot = 4
			KEY_6: slot = 5
			KEY_7: slot = 6
			KEY_8: slot = 7
			KEY_9: slot = 8
			KEY_0: slot = 9
		
		if slot >= 0:
			Inventory.select_slot(slot)

func _refresh_all():
	for i in range(10):
		_update_slot(i)

func _update_slot(slot: int):
	var item = Inventory.get_item(slot)
	var panel = slot_panels[slot]
	
	# Vérifier si les noeuds existent
	if not panel.has_node("VBox/Icon") or not panel.has_node("VBox/Label"):
		print("Warning: Missing nodes in slot %d" % slot)
		return
	
	var icon = panel.get_node("VBox/Icon")
	var label = panel.get_node("VBox/Label")
	
	# Slot 0 spécial = main (action sans objet)
	if slot == 0 and not item:
		if icon is Label:
			icon.text = "✋"  # Emoji main
			icon.add_theme_color_override("font_color", Color(1.0, 0.85, 0.6))
		label.text = "1: MAIN"
		panel.self_modulate = Color(1.0, 1.0, 1.0)
		return
	
	if item:
		# Item présent - couleur verte
		if icon is ColorRect:
			icon.color = Color(0.2, 0.6, 0.3)
		elif icon is Label:
			icon.text = "■"
			icon.add_theme_color_override("font_color", Color(0.2, 0.6, 0.3))
		panel.self_modulate = Color(1.1, 1.1, 1.1)
	else:
		# Slot vide - couleur gris sombre
		if icon is ColorRect:
			icon.color = Color(0.2, 0.2, 0.25)
		elif icon is Label:
			icon.text = ""
		panel.self_modulate = Color(1, 1, 1)
	
	# Update label (numéro + nom si item)
	var slot_num = slot + 1 if slot < 9 else 0
	if item:
		label.text = "%d: %s" % [slot_num, item.name.substr(0, 8)]
	else:
		label.text = "[%d]" % slot_num

func _on_item_added(_item: Dictionary, slot: int):
	_update_slot(slot)

func _on_item_removed(slot: int):
	_update_slot(slot)

func _on_slot_selected(slot: int, _item: Dictionary = {}):
	# Highlight slot sélectionné avec style de bordure
	for i in range(10):
		var panel = slot_panels[i]
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.15, 0.15, 0.2, 0.9)
		style_box.set_border_width_all(3)  # FIX: Utiliser set_border_width_all()
		style_box.set_corner_radius_all(5)  # FIX: Utiliser set_corner_radius_all()
		
		if i == slot:
			# Slot sélectionné - bordure dorée brillante
			style_box.border_color = Color(1.0, 0.85, 0.3)
			style_box.bg_color = Color(0.25, 0.22, 0.15, 0.95)
			panel.scale = Vector2(1.08, 1.08)
		else:
			# Slots non sélectionnés
			style_box.border_color = Color(0.4, 0.4, 0.5)
			panel.scale = Vector2(1.0, 1.0)
		
		panel.add_theme_stylebox_override("panel", style_box)
