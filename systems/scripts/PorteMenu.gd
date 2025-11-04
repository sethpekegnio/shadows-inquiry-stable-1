extends Control

@onready var line_edit = $VBoxContainer/HBoxContainer/LineEdit

func _ready():
	visible = false
	$VBoxContainer/ButtonCommissariat.pressed.connect(_go_commissariat)
	$VBoxContainer/ButtonShop.pressed.connect(_go_shop)
	$VBoxContainer/HBoxContainer/ButtonAdresse.pressed.connect(_go_adresse)
	$VBoxContainer/ButtonAnnuler.pressed.connect(hide)

func _go_commissariat():
	get_tree().change_scene_to_file("res://systems/scenes/locations/Commissariat.tscn")

func _go_shop():
	get_tree().change_scene_to_file("res://systems/scenes/locations/Shop.tscn")

func _go_adresse():
	var adresse = line_edit.text.strip_edges()
	if adresse == "":
		return
	print("Aller à : %s" % adresse)
	Global.donnees_joueur.derniere_adresse = adresse
	get_tree().change_scene_to_file("res://systems/scenes/locations/AdresseLibre.tscn")

func ouvrir():
	show()
	line_edit.text = ""
	line_edit.grab_focus()
