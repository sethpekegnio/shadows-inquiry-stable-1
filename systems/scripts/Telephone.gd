extends StaticBody3D

@export var temps_avant_premiere_sonnerie = 10.0
@export var temps_entre_sonneries = 150.0  # 2min30
@export var nombre_sonneries = 3

var sonneries_effectuees = 0
var timer_sonnerie: Timer
var telephone_deja_repondu = false
var est_en_train_de_sonner = false

signal telephone_repondu

func _ready():
	print("📞 Telephone initialized")
	
	# Créer le timer
	timer_sonnerie = Timer.new()
	add_child(timer_sonnerie)
	timer_sonnerie.one_shot = false
	timer_sonnerie.wait_time = temps_entre_sonneries
	timer_sonnerie.timeout.connect(_sonner)
	
	# Première sonnerie après délai
	await get_tree().create_timer(temps_avant_premiere_sonnerie).timeout
	if not telephone_deja_repondu:
		_sonner()
		timer_sonnerie.start()

func _sonner():
	if telephone_deja_repondu or sonneries_effectuees >= nombre_sonneries:
		timer_sonnerie.stop()
		return
	
	sonneries_effectuees += 1
	est_en_train_de_sonner = true
	
	print("📞 PHONE RINGING (%d/%d)" % [sonneries_effectuees, nombre_sonneries])
	
	# Animation visuelle simple
	_animer_sonnerie()
	
	if sonneries_effectuees >= nombre_sonneries:
		print("⚠️ All rings elapsed. Phone inactive.")
		timer_sonnerie.stop()

func _animer_sonnerie():
	# Clignotement simple
	var mesh = get_node_or_null("MeshInstance3D")
	if mesh:
		for i in range(3):
			await get_tree().create_timer(0.3).timeout
			mesh.scale = Vector3(1.2, 1.2, 1.2)
			await get_tree().create_timer(0.3).timeout
			mesh.scale = Vector3(1, 1, 1)
	
	est_en_train_de_sonner = false

func _on_interagir():
	print("📞 Opening telephone UI")
	_open_telephone_ui()

func _open_telephone_ui():
	var tel_scene = load("res://systems/scenes/ui/TelephoneUI.tscn")
	if tel_scene:
		var tel_ui = tel_scene.instantiate()
		get_tree().root.add_child(tel_ui)
	else:
		print("❌ TelephoneUI.tscn not found!")

func _handle_first_call():
	if telephone_deja_repondu:
		return
	
	telephone_deja_repondu = true
	Global.donnees_joueur.telephone_repondu = true
	timer_sonnerie.stop()
	
	print("📞 PHONE PICKED UP")
	print("🗣️ Commissioner: 'Detective, we have a position for you.'")
	print("🗣️ Commissioner: 'Come to the precinct for an interview.'")
	
	telephone_repondu.emit()
	
	await get_tree().create_timer(3.0).timeout
	print("💬 [Call ended]")
	print("➡️ You can now exit through the DOOR")
