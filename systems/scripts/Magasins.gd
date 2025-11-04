extends Node

func _ready():
	print("=== MAGASINS ===")
	
	# Charger directement le ShopUI
	var shop_scene = load("res://systems/scenes/ui/ShopUI.tscn")
	var shop_ui = shop_scene.instantiate()
	add_child(shop_ui)
	
	# Quand le shop se ferme, retour commissariat
	shop_ui.tree_exited.connect(_on_shop_closed)

func _on_shop_closed():
	print("🚪 Retour commissariat depuis shop")
	get_tree().change_scene_to_file("res://systems/scenes/locations/Commissariat.tscn")
