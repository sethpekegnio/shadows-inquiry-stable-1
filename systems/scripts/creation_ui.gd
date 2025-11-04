extends Popup

# ===== DONNÉES PERSONNAGE =====
var sexe_choisi = ""
var age = 30
var corpulence = 0  # -2 (thin) à +2 (heavy)
var hair_style = 1
var beard_style = 0  # 0 = none
var moustache_style = 0  # 0 = none

# Limites styles (pour l'instant numéros, plus tard images)
const MAX_HAIR = 10
const MAX_BEARD = 8
const MAX_MOUSTACHE = 6

# Références UI
@onready var btn_male = $Panel/VBoxContainer/HBoxMain/OptionsPanel/SexeGroup/HBoxSexe/BtnMale
@onready var btn_female = $Panel/VBoxContainer/HBoxMain/OptionsPanel/SexeGroup/HBoxSexe/BtnFemale

@onready var slider_age = $Panel/VBoxContainer/HBoxMain/OptionsPanel/AgeGroup/SliderAge
@onready var label_age = $Panel/VBoxContainer/HBoxMain/OptionsPanel/AgeGroup/LabelAge

@onready var slider_corpulence = $Panel/VBoxContainer/HBoxMain/OptionsPanel/CorpulenceGroup/SliderCorpulence
@onready var label_corpulence = $Panel/VBoxContainer/HBoxMain/OptionsPanel/CorpulenceGroup/LabelCorpulence

@onready var btn_prev_hair = $Panel/VBoxContainer/HBoxMain/OptionsPanel/HairGroup/HBoxHair/BtnPrevHair
@onready var btn_next_hair = $Panel/VBoxContainer/HBoxMain/OptionsPanel/HairGroup/HBoxHair/BtnNextHair
@onready var label_hair_num = $Panel/VBoxContainer/HBoxMain/OptionsPanel/HairGroup/HBoxHair/LabelHairNum

@onready var btn_prev_beard = $Panel/VBoxContainer/HBoxMain/OptionsPanel/BeardGroup/HBoxBeard/BtnPrevBeard
@onready var btn_next_beard = $Panel/VBoxContainer/HBoxMain/OptionsPanel/BeardGroup/HBoxBeard/BtnNextBeard
@onready var label_beard_num = $Panel/VBoxContainer/HBoxMain/OptionsPanel/BeardGroup/HBoxBeard/LabelBeardNum

@onready var btn_prev_moustache = $Panel/VBoxContainer/HBoxMain/OptionsPanel/MoustacheGroup/HBoxMoustache/BtnPrevMoustache
@onready var btn_next_moustache = $Panel/VBoxContainer/HBoxMain/OptionsPanel/MoustacheGroup/HBoxMoustache/BtnNextMoustache
@onready var label_moustache_num = $Panel/VBoxContainer/HBoxMain/OptionsPanel/MoustacheGroup/HBoxMoustache/LabelMoustacheNum

@onready var preview_character = $Panel/VBoxContainer/HBoxMain/PreviewPanel/VBoxPreview/PreviewCharacter
@onready var label_info = $Panel/VBoxContainer/HBoxMain/PreviewPanel/VBoxPreview/LabelInfo

@onready var btn_cancel = $Panel/VBoxContainer/ButtonsBottom/BtnCancel
@onready var btn_confirm = $Panel/VBoxContainer/ButtonsBottom/BtnConfirm

func _ready():
	print("=== CHARACTER CREATION ===")
	
	# Connexions boutons sexe
	btn_male.pressed.connect(func(): _choisir_sexe("Male"))
	btn_female.pressed.connect(func(): _choisir_sexe("Female"))
	
	# Connexions sliders
	slider_age.value_changed.connect(_on_age_changed)
	slider_corpulence.value_changed.connect(_on_corpulence_changed)
	
	# Connexions hair
	btn_prev_hair.pressed.connect(func(): _changer_hair(-1))
	btn_next_hair.pressed.connect(func(): _changer_hair(1))
	
	# Connexions beard
	btn_prev_beard.pressed.connect(func(): _changer_beard(-1))
	btn_next_beard.pressed.connect(func(): _changer_beard(1))
	
	# Connexions moustache
	btn_prev_moustache.pressed.connect(func(): _changer_moustache(-1))
	btn_next_moustache.pressed.connect(func(): _changer_moustache(1))
	
	# Connexions boutons finaux
	btn_cancel.pressed.connect(_annuler)
	btn_confirm.pressed.connect(_confirmer)
	
	# Init preview
	_update_preview()

# ===== SEXE =====
func _choisir_sexe(sexe: String):
	sexe_choisi = sexe
	print("Gender selected: ", sexe)
	
	# Style boutons
	btn_male.disabled = (sexe != "Male")
	btn_female.disabled = (sexe != "Female")
	
	_update_preview()

# ===== AGE =====
func _on_age_changed(value: float):
	age = int(value)
	label_age.text = "AGE: %d" % age
	_update_preview()

# ===== CORPULENCE =====
func _on_corpulence_changed(value: float):
	corpulence = int(value)
	var build_text = ""
	match corpulence:
		-2: build_text = "Very Thin"
		-1: build_text = "Thin"
		0: build_text = "Medium"
		1: build_text = "Heavy"
		2: build_text = "Very Heavy"
	
	label_corpulence.text = "BUILD: %s" % build_text
	_update_preview()

# ===== HAIR =====
func _changer_hair(direction: int):
	hair_style += direction
	hair_style = wrapi(hair_style, 1, MAX_HAIR + 1)
	label_hair_num.text = str(hair_style)
	_update_preview()

# ===== BEARD =====
func _changer_beard(direction: int):
	beard_style += direction
	beard_style = wrapi(beard_style, 0, MAX_BEARD + 1)
	label_beard_num.text = str(beard_style) if beard_style > 0 else "None"
	_update_preview()

# ===== MOUSTACHE =====
func _changer_moustache(direction: int):
	moustache_style += direction
	moustache_style = wrapi(moustache_style, 0, MAX_MOUSTACHE + 1)
	label_moustache_num.text = str(moustache_style) if moustache_style > 0 else "None"
	_update_preview()

# ===== PREVIEW =====
func _update_preview():
	# Mise à jour label info
	var build_name = ""
	match corpulence:
		-2: build_name = "Very Thin"
		-1: build_name = "Thin"
		0: build_name = "Medium"
		1: build_name = "Heavy"
		2: build_name = "Very Heavy"
	
	label_info.text = "Detective Profile\n\nGender: %s\nAge: %d\nBuild: %s\nHair: Style %d\nBeard: %s\nMoustache: %s" % [
		sexe_choisi if sexe_choisi != "" else "Not selected",
		age,
		build_name,
		hair_style,
		"Style %d" % beard_style if beard_style > 0 else "None",
		"Style %d" % moustache_style if moustache_style > 0 else "None"
	]
	
	# Preview visuel simple (couleur change selon corpulence)
	var color_base = Color(0.4, 0.4, 0.45)
	match corpulence:
		-2: color_base = Color(0.3, 0.3, 0.35)
		-1: color_base = Color(0.35, 0.35, 0.4)
		0: color_base = Color(0.4, 0.4, 0.45)
		1: color_base = Color(0.45, 0.45, 0.5)
		2: color_base = Color(0.5, 0.5, 0.55)
	
	if sexe_choisi == "Male":
		color_base.b += 0.1
	elif sexe_choisi == "Female":
		color_base.r += 0.1
	
	preview_character.color = color_base

# ===== ANNULER =====
func _annuler():
	print("Character creation cancelled")
	queue_free()

# ===== CONFIRMER =====
func _confirmer():
	if sexe_choisi == "":
		print("ERROR: Must select gender!")
		label_info.text = "⚠️ ERROR\nPlease select a gender!"
		return
	
	print("\n=== CHARACTER CREATED ===")
	print("Gender: %s" % sexe_choisi)
	print("Age: %d" % age)
	print("Build: %d" % corpulence)
	print("Hair: %d" % hair_style)
	print("Beard: %d" % beard_style)
	print("Moustache: %d" % moustache_style)
	
	# Sauvegarder dans Global
	Global.donnees_joueur.sexe = sexe_choisi
	Global.donnees_joueur.age = age
	Global.donnees_joueur.corpulence = corpulence
	Global.donnees_joueur.hair_style = hair_style
	Global.donnees_joueur.beard_style = beard_style
	Global.donnees_joueur.moustache_style = moustache_style
	Global.donnees_joueur.progression = "appartement"
	
	# Sauvegarder
	Global.auto_sauvegarder()
	
	print("✓ Character saved!")
	
	# Transition vers appartement
	queue_free()
	get_tree().change_scene_to_file("res://systems/scenes/locations/Appartement3D.tscn")
