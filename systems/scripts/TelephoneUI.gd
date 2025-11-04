extends Control

@onready var number_display = $Panel/VBox/NumberDisplay
@onready var btn_grid = $Panel/VBox/ButtonGrid
@onready var btn_call = $Panel/VBox/CallButton
@onready var btn_close = $Panel/CloseButton

var current_number = ""
const MAX_DIGITS = 10

func _ready():
	print("📞 TelephoneUI ready")
	_create_number_pad()
	btn_call.pressed.connect(_on_call_pressed)
	btn_close.pressed.connect(_on_close)
	number_display.text = ""

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_close()

func _create_number_pad():
	# Créer les boutons 1-9, 0
	var buttons_layout = [
		["1", "2", "3"],
		["4", "5", "6"],
		["7", "8", "9"],
		["*", "0", "#"]
	]
	
	for row in buttons_layout:
		for digit in row:
			var btn = Button.new()
			btn.text = digit
			btn.custom_minimum_size = Vector2(80, 80)
			btn.add_theme_font_size_override("font_size", 32)
			btn.pressed.connect(_on_digit_pressed.bind(digit))
			btn_grid.add_child(btn)

func _on_digit_pressed(digit: String):
	if current_number.length() >= MAX_DIGITS:
		return
	
	current_number += digit
	number_display.text = current_number
	print("📞 Numéro : %s" % current_number)

func _on_call_pressed():
	if current_number == "":
		print("⚠️ Aucun numéro saisi")
		return
	
	print("📞 Appel : %s" % current_number)
	
	# Vérifier si c'est un numéro connu
	var known_numbers = {
		"5551234567": "Directeur du Commissariat",
		"5559876543": "Informateur",
		"911": "Urgences"
	}
	
	if known_numbers.has(current_number):
		_show_call_result("📞 Appel vers : %s\n\n(Dialogue à implémenter)" % known_numbers[current_number])
	else:
		_show_call_result("📞 Numéro inconnu : %s\n\nPas de réponse..." % current_number)
	
	# Sauvegarder l'appel
	if not Global.donnees_joueur.has("phone_calls"):
		Global.donnees_joueur.phone_calls = []
	
	Global.donnees_joueur.phone_calls.append({
		"number": current_number,
		"timestamp": Time.get_unix_time_from_system()
	})

func _show_call_result(message: String):
	var result_label = Label.new()
	result_label.text = message
	result_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# Remplacer temporairement le contenu
	var vbox = $Panel/VBox
	for child in vbox.get_children():
		child.visible = false
	
	vbox.add_child(result_label)
	
	# Retour après 3 secondes
	await get_tree().create_timer(3.0).timeout
	
	result_label.queue_free()
	for child in vbox.get_children():
		child.visible = true
	
	current_number = ""
	number_display.text = ""

func _on_close():
	queue_free()
