# res://systems/scripts/CarnetUI.gd
extends Control

@onready var page = $BookContainer/BookPanel/PageContainer/Page
@onready var text_edit = $BookContainer/BookPanel/PageContainer/Page/TextEdit
@onready var num_page = $BookContainer/BookPanel/PageContainer/Page/NumPage
@onready var btn_prev = $BookContainer/BookPanel/ButtonPrevious
@onready var btn_next = $BookContainer/BookPanel/ButtonNext
@onready var btn_close = $BookContainer/BookPanel/CloseButton
@onready var save_timer = $SaveTimer

const MAX_CHARS_PER_PAGE = 2000
var is_dirty = false

func _ready():
	print("📓 CarnetUI ready (simple version)")
	
	# Connexions
	btn_prev.pressed.connect(_on_previous_page)
	btn_next.pressed.connect(_on_next_page)
	btn_close.pressed.connect(_on_close)
	text_edit.text_changed.connect(_on_text_changed)
	save_timer.timeout.connect(_auto_save)
	
	# Charger page
	_load_current_page()
	save_timer.start()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_close()

func _load_current_page():
	var page_idx = Global.current_page
	
	# Assurer que la page existe
	while Global.carnet_data.size() <= page_idx:
		Global.carnet_data.append("")
	
	# Charger contenu selon index
	if page_idx == 0:
		_show_cover_page()
	elif page_idx == 1:
		_show_stats_page()
	else:
		_show_editable_page(page_idx)
	
	# Boutons navigation
	btn_prev.disabled = (Global.current_page == 0)
	num_page.text = "Page %d" % (page_idx + 1)

func _show_cover_page():
	text_edit.visible = false
	text_edit.editable = false
	
	# Créer couverture si pas déjà fait
	var cover_label = page.get_node_or_null("CoverLabel")
	if not cover_label:
		page.add_theme_stylebox_override("panel", StyleBoxFlat.new())
		var style = page.get_theme_stylebox("panel") as StyleBoxFlat
		style.bg_color = Color(0.4, 0.1, 0.1)
		
		cover_label = Label.new()
		cover_label.name = "CoverLabel"
		cover_label.set_anchors_preset(Control.PRESET_CENTER)
		cover_label.grow_horizontal = Control.GROW_DIRECTION_BOTH
		cover_label.grow_vertical = Control.GROW_DIRECTION_BOTH
		cover_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		cover_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		var full_name = "%s %s" % [
			Global.donnees_joueur.get("first_name", "???"),
			Global.donnees_joueur.get("last_name", "???")
		]
		
		cover_label.text = "AUTOBIOGRAPHIE\n\nde l'Inspecteur\n\n" + full_name.to_upper()
		cover_label.add_theme_font_size_override("font_size", 24)
		cover_label.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
		page.add_child(cover_label)
	else:
		cover_label.visible = true

func _show_stats_page():
	# Cacher label couverture
	var cover_label = page.get_node_or_null("CoverLabel")
	if cover_label:
		cover_label.visible = false
	
	text_edit.visible = true
	text_edit.editable = false
	
	# Couleur noir pour les stats
	text_edit.add_theme_color_override("font_color", Color(0, 0, 0))
	
	# Générer texte stats
	var stats = Global.donnees_joueur.stats
	var stats_text = "═══ STATISTIQUES ═══\n\n"
	
	var stat_names = {
		"Violence": "⚔️ Violence",
		"Empathie": "❤️ Empathie",
		"Intuition": "🔍 Intuition",
		"Resilience": "🛡️ Résilience",
		"Allies": "🤝 Alliés",
		"Corruption": "💀 Corruption",
		"SanteMentale": "🧠 Santé Mentale",
		"Reputation": "⭐ Réputation",
		"Ressources": "💰 Ressources",
		"Karma": "⚖️ Karma"
	}
	
	for stat_key in stat_names.keys():
		var stat_value = stats.get(stat_key, 0)
		stats_text += "%s : %d\n" % [stat_names[stat_key], stat_value]
	
	stats_text += "\n─────────────────\n"
	stats_text += "Enquêtes résolues : %d\n" % Global.donnees_joueur.enquetes_resolues.size()
	stats_text += "Temps de jeu : %d min" % int(Global.donnees_joueur.temps_jeu / 60)
	
	text_edit.text = stats_text

func _show_editable_page(page_idx: int):
	# Cacher label couverture
	var cover_label = page.get_node_or_null("CoverLabel")
	if cover_label:
		cover_label.visible = false
	
	text_edit.visible = true
	text_edit.editable = true
	
	# Couleur noir pour les pages d'écriture aussi
	text_edit.add_theme_color_override("font_color", Color(0, 0, 0))
	
	text_edit.text = Global.carnet_data[page_idx]

func _on_text_changed():
	if Global.current_page >= 2:  # Seulement pages éditables
		is_dirty = true
		Global.carnet_data[Global.current_page] = text_edit.text
		
		# Auto-créer nouvelle page si trop de texte
		if text_edit.text.length() > MAX_CHARS_PER_PAGE:
			print("⚠️ Page pleine, création page suivante")
			Global.current_page += 1
			_load_current_page()

func _on_previous_page():
	if Global.current_page > 0:
		Global.current_page -= 1
		_load_current_page()

func _on_next_page():
	Global.current_page += 1
	_load_current_page()

func _auto_save():
	if is_dirty:
		Global.auto_sauvegarder()
		is_dirty = false

func _on_close():
	Global.auto_sauvegarder()
	queue_free()
