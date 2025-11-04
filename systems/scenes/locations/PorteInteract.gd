# res://systems/scripts/PorteInteract.gd
extends Area3D

# Chemin vers le menu (change si ton nœud s'appelle autrement)
@export var porte_menu_path: NodePath = "PorteMenuUI"

# Référence au menu (on la récupère au démarrage)
@onready var porte_menu = get_node(porte_menu_path)

# Vérifie qu'on a bien le menu
func _ready():
	if not porte_menu:
		push_error("PorteInteract: PorteMenuUI non trouvé ! Vérifie le chemin.")
		return
	print("PorteInteract: Menu trouvé → ", porte_menu.name)

# Quand le joueur entre dans la zone
func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Joueur près de la porte → Appuie E pour ouvrir le menu")

# Quand le joueur sort
func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Joueur loin de la porte")

# Gestion de l'appui sur E
func _input(event):
	if event.is_action_pressed("interagir") and has_overlapping_bodies():
		var player_inside = false
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):
				player_inside = true
				break
		if player_inside and porte_menu:
			porte_menu.ouvrir()
			print("Menu destinations ouvert !")
