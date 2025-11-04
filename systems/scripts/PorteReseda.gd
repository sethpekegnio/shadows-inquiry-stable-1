extends StaticBody3D

signal porte_utilisee

func _ready():
	print("🚪 PorteReseda initialized")

func _on_interagir():
	_show_destination_menu()

func _show_destination_menu():
	print("📍 Opening Reseda exit menu...")
	
	var menu = DestinationMenu.new()
	var destinations = [
		{"name": "Return to Precinct", "scene": "res://systems/scenes/locations/Commissariat.tscn", "always_available": true}
	]
	menu.destinations_set(destinations)
	menu.destination_selected.connect(_go_to_destination)
	get_tree().root.add_child(menu)
	menu.popup_centered()

func _go_to_destination(scene_path: String):
	print("🚪 Returning to: %s" % scene_path)
	porte_utilisee.emit()
	
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file(scene_path)

class DestinationMenu extends Popup:
	var destinations_list = []
	signal destination_selected(scene_path: String)
	
	func destinations_set(dests: Array):
		destinations_list = dests
		_build_ui()
	
	func _build_ui():
		size = Vector2i(400, 250)
		
		var vbox = VBoxContainer.new()
		add_child(vbox)
		vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
		vbox.offset_left = 20
		vbox.offset_top = 20
		vbox.offset_right = -20
		vbox.offset_bottom = -20
		
		var title_label = Label.new()
		title_label.text = "LEAVE APARTMENT"
		title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		title_label.add_theme_font_size_override("font_size", 24)
		vbox.add_child(title_label)
		
		var sep = HSeparator.new()
		vbox.add_child(sep)
		
		for dest in destinations_list:
			var btn = Button.new()
			btn.text = dest.name
			btn.custom_minimum_size = Vector2(0, 60)
			btn.pressed.connect(_on_destination_selected.bind(dest.scene))
			vbox.add_child(btn)
		
		var btn_cancel = Button.new()
		btn_cancel.text = "Cancel"
		btn_cancel.custom_minimum_size = Vector2(0, 50)
		btn_cancel.pressed.connect(queue_free)
		vbox.add_child(btn_cancel)
	
	func _on_destination_selected(scene_path: String):
		destination_selected.emit(scene_path)
		queue_free()
