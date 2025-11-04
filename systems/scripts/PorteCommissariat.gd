extends StaticBody3D

@export var custom_destinations: Array[Dictionary] = []

var peut_interagir = true
signal porte_utilisee

var commissariat_destinations = [
	{"name": "Apartment", "scene": "res://systems/scenes/locations/Appartement3D.tscn", "always_available": true},
	{"name": "Shops", "scene": "res://systems/scenes/locations/Magasins.tscn", "always_available": true},
	{"name": "Enter Address...", "scene": "", "always_available": true, "is_manual_address": true}
]

func _ready():
	print("🚪 PorteCommissariat initialized")

func _on_interagir():
	_show_destination_menu()

func _show_destination_menu():
	print("📍 Opening commissariat destination menu...")
	
	var menu = DestinationMenu.new()
	menu.destinations_set(commissariat_destinations)
	menu.destination_selected.connect(_go_to_destination)
	get_tree().root.add_child(menu)
	menu.popup_centered()

func _go_to_destination(scene_path: String):
	print("🚪 Going to: %s" % scene_path)
	Global.set_progression("travelling")
	porte_utilisee.emit()
	
	# Attendre la fin du frame pour que le popup soit bien fermé
	await get_tree().process_frame
	
	# Changer de scène
	print("🔄 Changement de scène en cours...")
	var result = get_tree().change_scene_to_file(scene_path)
	if result != OK:
		push_error("❌ Erreur changement scène: %d" % result)
	else:
		print("✓ Scène chargée avec succès")

class DestinationMenu extends Popup:
	var destinations_list = []
	var address_input: LineEdit
	var error_label: Label
	signal destination_selected(scene_path: String)
	
	func destinations_set(dests: Array):
		destinations_list = dests
		_build_ui()
	
	func _build_ui():
		size = Vector2i(500, 400)
		
		var vbox = VBoxContainer.new()
		add_child(vbox)
		vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
		vbox.offset_left = 20
		vbox.offset_top = 20
		vbox.offset_right = -20
		vbox.offset_bottom = -20
		
		var title_label = Label.new()
		title_label.text = "SELECT DESTINATION"
		title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		title_label.add_theme_font_size_override("font_size", 24)
		vbox.add_child(title_label)
		
		var sep = HSeparator.new()
		vbox.add_child(sep)
		
		for dest in destinations_list:
			if dest.always_available or _check_if_available(dest):
				if dest.get("is_manual_address", false):
					_add_manual_address_section(vbox)
				else:
					var btn = Button.new()
					btn.text = dest.name
					btn.custom_minimum_size = Vector2(0, 50)
					btn.pressed.connect(_on_destination_selected.bind(dest.scene))
					vbox.add_child(btn)
		
		var btn_cancel = Button.new()
		btn_cancel.text = "Cancel"
		btn_cancel.custom_minimum_size = Vector2(0, 50)
		btn_cancel.pressed.connect(queue_free)
		vbox.add_child(btn_cancel)
	
	func _add_manual_address_section(vbox: VBoxContainer):
		var sep2 = HSeparator.new()
		vbox.add_child(sep2)
		
		var label_address = Label.new()
		label_address.text = "Or enter address manually:"
		label_address.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(label_address)
		
		address_input = LineEdit.new()
		address_input.placeholder_text = "Type exact address (case sensitive)"
		address_input.custom_minimum_size = Vector2(0, 40)
		vbox.add_child(address_input)
		
		error_label = Label.new()
		error_label.text = ""
		error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		error_label.add_theme_color_override("font_color", Color(1, 0.2, 0.2))
		vbox.add_child(error_label)
		
		var btn_go = Button.new()
		btn_go.text = "🔍 GO TO ADDRESS"
		btn_go.custom_minimum_size = Vector2(0, 45)
		btn_go.pressed.connect(_on_manual_address_submitted)
		vbox.add_child(btn_go)
		
		address_input.text_submitted.connect(func(_text): _on_manual_address_submitted())
	
	func _on_manual_address_submitted():
		var address = address_input.text.strip_edges()
		
		print("🔍 Adresse tapée : '%s'" % address)
		
		if address == "":
			_show_error("⚠️ Enter an address!")
			return
		
		var valid_addresses = {
			"Appartement": "res://systems/scenes/locations/Appartement3D.tscn",
			"Apt 4B, 2700 Saticoy Street, Reseda, Los Angeles": "res://systems/scenes/locations/AptReseda.tscn"
		}
		
		print("🔍 Adresses valides disponibles")
		
		# Vérifier aussi avec des variantes
		var address_lower = address.to_lower()
		print("🔍 Adresse en minuscules : '%s'" % address_lower)
		
		for valid_addr in valid_addresses.keys():
			print("🔍 Comparaison avec : '%s'" % valid_addr.to_lower())
			if valid_addr.to_lower() == address_lower:
				print("✓ MATCH ! Valid address: %s" % valid_addr)
				destination_selected.emit(valid_addresses[valid_addr])
				hide()  # Cache le popup
				queue_free()  # Détruit le popup
				return
		
		print("❌ Aucune correspondance trouvée")
		_show_error("❌ Address not found")
	
	func _show_error(message: String):
		if error_label:
			error_label.text = message
	
	func _check_if_available(_dest: Dictionary) -> bool:
		return false
	
	func _on_destination_selected(scene_path: String):
		print("📍 Destination sélectionnée: %s" % scene_path)
		destination_selected.emit(scene_path)
		hide()  # Cache d'abord
		queue_free()  # Puis détruit
