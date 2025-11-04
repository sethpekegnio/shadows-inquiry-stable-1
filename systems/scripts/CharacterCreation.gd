extends Control

var character_data = {
	"last_name": "",
	"first_name": "",
	"age": 30,
	"hair_style": 1,
	"hair_color_index": 0,
	"beard_style": 0,
	"beard_color_index": 0,
	"moustache_style": 0,
	"moustache_color_index": 0,
	"corpulence": 0.0,
	"weight": 75
}

const MAX_HAIR = 10
const MAX_BEARD = 8
const MAX_MOUSTACHE = 6

const HAIR_COLORS = [
	{"name": "Black", "color": Color(0.1, 0.1, 0.12)},
	{"name": "Dark Brown", "color": Color(0.2, 0.1, 0.05)},
	{"name": "Brown", "color": Color(0.4, 0.25, 0.15)},
	{"name": "Light Brown", "color": Color(0.6, 0.4, 0.25)},
	{"name": "Blonde", "color": Color(0.9, 0.8, 0.5)},
	{"name": "Red", "color": Color(0.7, 0.2, 0.1)},
	{"name": "Auburn", "color": Color(0.5, 0.15, 0.1)},
	{"name": "Gray", "color": Color(0.6, 0.6, 0.6)},
	{"name": "White", "color": Color(0.9, 0.9, 0.9)}
]

const BASE_WEIGHT = 75
const WEIGHT_VARIATION = 10

@onready var preview_character = $MainContainer/LeftPanel/VBoxLeft/MirrorFrame/PreviewCharacter
@onready var preview_info = $MainContainer/LeftPanel/VBoxLeft/PreviewInfo
@onready var photo_preview = $BottomPanel/IDCardContainer/IDCardPhoto/PhotoPreview

@onready var btn_prev_hair = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairStyle/BtnPrevHair
@onready var btn_next_hair = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairStyle/BtnNextHair
@onready var label_hair_num = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairStyle/LabelHairNum

@onready var btn_prev_hair_color = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairColor/BtnPrevHairColor
@onready var btn_next_hair_color = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairColor/BtnNextHairColor
@onready var color_preview_hair = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairColor/ColorPreviewHair
@onready var label_hair_color_name = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/HairSection/HBoxHairColor/LabelHairColorName

@onready var btn_prev_beard = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardStyle/BtnPrevBeard
@onready var btn_next_beard = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardStyle/BtnNextBeard
@onready var label_beard_num = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardStyle/LabelBeardNum

@onready var btn_prev_beard_color = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardColor/BtnPrevBeardColor
@onready var btn_next_beard_color = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardColor/BtnNextBeardColor
@onready var color_preview_beard = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardColor/ColorPreviewBeard
@onready var label_beard_color_name = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/BeardSection/HBoxBeardColor/LabelBeardColorName

@onready var btn_prev_moustache = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheStyle/BtnPrevMoustache
@onready var btn_next_moustache = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheStyle/BtnNextMoustache
@onready var label_moustache_num = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheStyle/LabelMoustacheNum

@onready var btn_prev_moustache_color = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheColor/BtnPrevMoustacheColor
@onready var btn_next_moustache_color = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheColor/BtnNextMoustacheColor
@onready var color_preview_moustache = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheColor/ColorPreviewMoustache
@onready var label_moustache_color_name = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/MoustacheSection/HBoxMoustacheColor/LabelMoustacheColorName

@onready var slider_corpulence = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/CorpulenceSection/SliderCorpulence
@onready var label_corpulence = $MainContainer/RightPanel/ScrollContainer/VBoxOptions/CorpulenceSection/LabelCorpulence

@onready var input_name = $BottomPanel/IDCardContainer/IDCardForm/HBoxName/InputName
@onready var input_first_name = $BottomPanel/IDCardContainer/IDCardForm/HBoxFirstName/InputFirstName
@onready var spinbox_age = $BottomPanel/IDCardContainer/IDCardForm/HBoxAge/SpinBoxAge
@onready var spinbox_weight = $BottomPanel/IDCardContainer/IDCardForm/HBoxWeight/SpinBoxWeight
@onready var label_weight = $BottomPanel/IDCardContainer/IDCardForm/HBoxWeight/LabelWeight

@onready var btn_cancel = $BottomPanel/IDCardContainer/ButtonsContainer/BtnCancel
@onready var btn_confirm = $BottomPanel/IDCardContainer/ButtonsContainer/BtnConfirm

func _ready():
	print("=== CHARACTER CREATION ===")
	
	# Vérifier si la musique persistante existe déjà
	var persistent_music = get_tree().root.get_node_or_null("MenuMusicPersistent")
	if persistent_music:
		print("🎵 Musique menu continue de jouer")
	
	# Cacher preview_info (infos déjà visibles à droite)
	if preview_info:
		preview_info.visible = false
	
	# Scale de 85% pour toute l'interface
	scale = Vector2(0.85, 0.85)
	
	_connect_signals()
	_update_all_ui()

func _connect_signals():
	btn_prev_hair.pressed.connect(func(): _change_hair(-1))
	btn_next_hair.pressed.connect(func(): _change_hair(1))
	btn_prev_hair_color.pressed.connect(func(): _change_hair_color(-1))
	btn_next_hair_color.pressed.connect(func(): _change_hair_color(1))
	
	btn_prev_beard.pressed.connect(func(): _change_beard(-1))
	btn_next_beard.pressed.connect(func(): _change_beard(1))
	btn_prev_beard_color.pressed.connect(func(): _change_beard_color(-1))
	btn_next_beard_color.pressed.connect(func(): _change_beard_color(1))
	
	btn_prev_moustache.pressed.connect(func(): _change_moustache(-1))
	btn_next_moustache.pressed.connect(func(): _change_moustache(1))
	btn_prev_moustache_color.pressed.connect(func(): _change_moustache_color(-1))
	btn_next_moustache_color.pressed.connect(func(): _change_moustache_color(1))
	
	slider_corpulence.value_changed.connect(_on_corpulence_changed)
	spinbox_age.value_changed.connect(_on_age_changed)
	
	# Connexion spinbox weight
	if spinbox_weight:
		spinbox_weight.value_changed.connect(_on_weight_changed)
	
	btn_cancel.pressed.connect(_on_cancel)
	btn_confirm.pressed.connect(_on_confirm)

func _change_hair(direction: int):
	character_data.hair_style += direction
	character_data.hair_style = wrapi(character_data.hair_style, 1, MAX_HAIR + 1)
	_update_all_ui()

func _change_hair_color(direction: int):
	character_data.hair_color_index += direction
	character_data.hair_color_index = wrapi(character_data.hair_color_index, 0, len(HAIR_COLORS))
	_update_all_ui()

func _change_beard(direction: int):
	character_data.beard_style += direction
	character_data.beard_style = wrapi(character_data.beard_style, 0, MAX_BEARD + 1)
	_update_all_ui()

func _change_beard_color(direction: int):
	character_data.beard_color_index += direction
	character_data.beard_color_index = wrapi(character_data.beard_color_index, 0, len(HAIR_COLORS))
	_update_all_ui()

func _change_moustache(direction: int):
	character_data.moustache_style += direction
	character_data.moustache_style = wrapi(character_data.moustache_style, 0, MAX_MOUSTACHE + 1)
	_update_all_ui()

func _change_moustache_color(direction: int):
	character_data.moustache_color_index += direction
	character_data.moustache_color_index = wrapi(character_data.moustache_color_index, 0, len(HAIR_COLORS))
	_update_all_ui()

func _on_corpulence_changed(value: float):
	character_data.corpulence = value
	character_data.weight = BASE_WEIGHT + int(character_data.corpulence * WEIGHT_VARIATION)
	
	# Mettre à jour le spinbox weight
	if spinbox_weight:
		spinbox_weight.value = character_data.weight
	
	_update_all_ui()

func _on_weight_changed(value: float):
	character_data.weight = int(value)
	# Recalculer corpulence depuis weight
	character_data.corpulence = float(character_data.weight - BASE_WEIGHT) / WEIGHT_VARIATION
	slider_corpulence.value = character_data.corpulence
	_update_all_ui()

func _on_age_changed(value: float):
	character_data.age = int(value)

func _update_all_ui():
	label_hair_num.text = "Style %d" % character_data.hair_style
	var hair_color_data = HAIR_COLORS[character_data.hair_color_index]
	color_preview_hair.color = hair_color_data.color
	label_hair_color_name.text = hair_color_data.name
	
	if character_data.beard_style == 0:
		label_beard_num.text = "None"
	else:
		label_beard_num.text = "Style %d" % character_data.beard_style
	var beard_color_data = HAIR_COLORS[character_data.beard_color_index]
	color_preview_beard.color = beard_color_data.color
	label_beard_color_name.text = beard_color_data.name
	
	if character_data.moustache_style == 0:
		label_moustache_num.text = "None"
	else:
		label_moustache_num.text = "Style %d" % character_data.moustache_style
	var moustache_color_data = HAIR_COLORS[character_data.moustache_color_index]
	color_preview_moustache.color = moustache_color_data.color
	label_moustache_color_name.text = moustache_color_data.name
	
	var build_name = _get_build_name()
	label_corpulence.text = "BODY BUILD: %s (%d kg)" % [build_name, character_data.weight]
	
	# Mettre à jour spinbox weight
	if spinbox_weight:
		spinbox_weight.value = character_data.weight
	
	_update_preview()

func _get_build_name() -> String:
	if character_data.corpulence <= -1.5:
		return "Very Thin"
	elif character_data.corpulence <= -0.5:
		return "Thin"
	elif character_data.corpulence <= 0.5:
		return "Medium"
	elif character_data.corpulence <= 1.5:
		return "Heavy"
	else:
		return "Very Heavy"

func _update_preview():
	var base_color = Color(0.35, 0.3, 0.28)
	var corpulence_factor = (character_data.corpulence + 2.0) / 4.0
	base_color = base_color.lerp(Color(0.5, 0.45, 0.4), corpulence_factor * 0.3)
	
	var hair_color = HAIR_COLORS[character_data.hair_color_index].color
	base_color = base_color.lerp(hair_color, 0.2)
	
	preview_character.color = base_color
	photo_preview.color = base_color
	
	preview_info.text = "Hair: Style %d (%s)\nBeard: %s\nMoustache: %s\nBuild: %s" % [
		character_data.hair_style,
		HAIR_COLORS[character_data.hair_color_index].name,
		"Style %d" % character_data.beard_style if character_data.beard_style > 0 else "None",
		"Style %d" % character_data.moustache_style if character_data.moustache_style > 0 else "None",
		_get_build_name()
	]

func _on_cancel():
	print("Character creation cancelled")
	get_tree().change_scene_to_file("res://systems/scenes/locations/MainMenu.tscn")

func _on_confirm():
	character_data.last_name = input_name.text.strip_edges().to_upper()
	character_data.first_name = input_first_name.text.strip_edges().capitalize()
	character_data.age = int(spinbox_age.value)
	
	if character_data.last_name == "":
		preview_info.text = "⚠️ Enter last name!"
		return
	
	if character_data.first_name == "":
		preview_info.text = "⚠️ Enter first name!"
		return
	
	print("=== CHARACTER CREATED ===")
	print("Name: %s %s, Age: %d" % [character_data.first_name, character_data.last_name, character_data.age])
	
	Global.donnees_joueur.first_name = character_data.first_name
	Global.donnees_joueur.last_name = character_data.last_name
	Global.donnees_joueur.age = character_data.age
	Global.donnees_joueur.weight = character_data.weight
	Global.donnees_joueur.corpulence = character_data.corpulence
	Global.donnees_joueur.hair_style = character_data.hair_style
	Global.donnees_joueur.hair_color = HAIR_COLORS[character_data.hair_color_index].name
	Global.donnees_joueur.beard_style = character_data.beard_style
	Global.donnees_joueur.beard_color = HAIR_COLORS[character_data.beard_color_index].name
	Global.donnees_joueur.moustache_style = character_data.moustache_style
	Global.donnees_joueur.moustache_color = HAIR_COLORS[character_data.moustache_color_index].name
	Global.donnees_joueur.progression = "appartement_debut"
	
	Global.auto_sauvegarder()
	print("✓ Saved! Going to apartment...")
	
	get_tree().change_scene_to_file("res://systems/scenes/locations/Appartement3D.tscn")
