# res://systems/scripts/ShopUI.gd
# Interface du magasin - Version propre et testée
extends Control

@onready var scroll_container = $Panel/ScrollContainer
@onready var items_grid = $Panel/ScrollContainer/ItemsGrid
@onready var label_money = $Panel/TopBar/LabelMoney
@onready var btn_close = $Panel/TopBar/CloseButton

var filter_bar: HBoxContainer
var current_filter = "all"
var catalogue = []

func _ready():
	print("🏪 Shop UI ready")
	
	# Créer FilterBar dynamiquement
	var top_bar = get_node_or_null("Panel/TopBar")
	if top_bar:
		filter_bar = top_bar.get_node_or_null("FilterBar")
		if not filter_bar:
			filter_bar = HBoxContainer.new()
			filter_bar.name = "FilterBar"
			top_bar.add_child(filter_bar)
	
	# Charger items depuis ItemDatabase
	catalogue = ItemDatabase.get_all_items()
	print("📦 Catalogue chargé : %d items" % catalogue.size())
	
	# Connecter boutons
	btn_close.pressed.connect(_on_close)
	
	# Créer filtres
	_create_filter_buttons()
	
	# Afficher argent et items
	_update_money_display()
	_populate_shop()

func _create_filter_buttons():
	var categories = [
		{"id": "all", "name": "Tous"},
		{"id": "weapon", "name": "Armes"},
		{"id": "chemical", "name": "Chimie"},
		{"id": "tool", "name": "Outils"},
		{"id": "tech", "name": "Tech"},
		{"id": "misc", "name": "Divers"}
	]
	
	for cat in categories:
		var btn = Button.new()
		btn.text = cat.name
		btn.custom_minimum_size = Vector2(90, 35)
		btn.pressed.connect(_on_filter_changed.bind(cat.id))
		filter_bar.add_child(btn)

func _on_filter_changed(filter: String):
	current_filter = filter
	_populate_shop()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_close()

func _update_money_display():
	var money = Global.donnees_joueur.stats.get("Ressources", 0) * 100
	label_money.text = "💰 %d $" % money

func _populate_shop():
	# Nettoyer grille
	for child in items_grid.get_children():
		child.queue_free()
	
	# Filtrer items
	var filtered = []
	if current_filter == "all":
		filtered = catalogue
	else:
		for item in catalogue:
			if item.category == current_filter:
				filtered.append(item)
	
	# Créer cartes items
	for item in filtered:
		var card = _create_item_card(item)
		items_grid.add_child(card)
	
	print("📦 Affichés : %d items" % filtered.size())

func _create_item_card(item: Dictionary) -> Panel:
	var card = Panel.new()
	card.custom_minimum_size = Vector2(200, 280)
	
	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.add_theme_constant_override("separation", 5)
	vbox.offset_left = 10
	vbox.offset_top = 10
	vbox.offset_right = -10
	vbox.offset_bottom = -10
	card.add_child(vbox)
	
	# Icône
	var icon_label = Label.new()
	icon_label.text = item.icon
	icon_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	icon_label.add_theme_font_size_override("font_size", 48)
	icon_label.custom_minimum_size = Vector2(0, 60)
	vbox.add_child(icon_label)
	
	# Nom
	var name_label = Label.new()
	name_label.text = item.name
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_label.add_theme_font_size_override("font_size", 14)
	name_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	vbox.add_child(name_label)
	
	# Description
	var desc_label = Label.new()
	desc_label.text = item.description
	desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	desc_label.custom_minimum_size = Vector2(0, 60)
	desc_label.add_theme_font_size_override("font_size", 11)
	vbox.add_child(desc_label)
	
	# Catégorie
	var cat_label = Label.new()
	var cat_names = {
		"weapon": "⚔️ ARME",
		"chemical": "🧪 CHIMIQUE",
		"tool": "🔧 OUTIL",
		"tech": "💻 TECH",
		"misc": "📦 DIVERS"
	}
	cat_label.text = cat_names.get(item.category, "")
	cat_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	cat_label.add_theme_font_size_override("font_size", 10)
	cat_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
	vbox.add_child(cat_label)
	
	# Spacer
	var spacer = Control.new()
	spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(spacer)
	
	# Prix
	var price_label = Label.new()
	price_label.text = "%d $" % item.price
	price_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	price_label.add_theme_font_size_override("font_size", 18)
	price_label.add_theme_color_override("font_color", Color(0, 0.8, 0))
	vbox.add_child(price_label)
	
	# Bouton acheter
	var btn_buy = Button.new()
	btn_buy.text = "ACHETER"
	btn_buy.custom_minimum_size = Vector2(0, 40)
	btn_buy.pressed.connect(_on_buy_item.bind(item))
	vbox.add_child(btn_buy)
	
	return card

func _on_buy_item(item: Dictionary):
	var money = Global.donnees_joueur.stats.get("Ressources", 0) * 100
	
	if money >= item.price:
		# Déduire argent
		var new_resources = (money - item.price) / 100
		Global.donnees_joueur.stats.Ressources = new_resources
		
		# Créer item pour inventaire
		var inventory_item = {
			"id": item.id,
			"name": item.name,
			"icon": item.icon,
			"actions": item.actions,
			"type": item.category,
			"description": item.description
		}
		
		# Ajouter à inventaire
		if Inventory.add_item(inventory_item):
			print("✓ Acheté : %s" % item.name)
			_update_money_display()
			_show_notification("✓ %s acheté !" % item.name, Color(0, 1, 0))
		else:
			# Rembourser si inventaire plein
			Global.donnees_joueur.stats.Ressources = money / 100
			_show_notification("❌ Inventaire plein !", Color(1, 0, 0))
	else:
		_show_notification("❌ Pas assez d'argent !", Color(1, 0.5, 0))

func _show_notification(text: String, color: Color = Color(1, 1, 0)):
	var notif = Label.new()
	notif.text = text
	notif.add_theme_font_size_override("font_size", 20)
	notif.add_theme_color_override("font_color", color)
	notif.position = Vector2(400, 50)
	notif.z_index = 100
	add_child(notif)
	
	await get_tree().create_timer(2.5).timeout
	notif.queue_free()

func _on_close():
	queue_free()
