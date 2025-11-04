extends Node

# Singleton pour gérer les sauvegardes de manière centralisée

const SAVE_PATH = "user://sauvegarde.json"

var current_save_data = {}

func _ready():
	print("=== SaveManager initialisé ===")
	load_game()

# Charge la sauvegarde si elle existe
func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("Aucune sauvegarde trouvée")
		return false
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("Impossible d'ouvrir le fichier de sauvegarde")
		return false
	
	var json_text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_text)
	
	if parse_result == OK:
		current_save_data = json.data
		print("✓ Sauvegarde chargée: ", current_save_data)
		return true
	else:
		push_error("Erreur parsing JSON: ", json.get_error_message())
		return false

# Sauvegarde les données
func save_game(data: Dictionary) -> bool:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if not file:
		push_error("Impossible de créer le fichier de sauvegarde")
		return false
	
	file.store_string(JSON.stringify(data, "\t"))
	file.close()
	
	current_save_data = data
	print("✓ Sauvegarde réussie: ", data)
	return true

# Vérifie si une sauvegarde existe
func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

# Supprime la sauvegarde
func delete_save() -> bool:
	if save_exists():
		DirAccess.remove_absolute(SAVE_PATH)
		current_save_data = {}
		print("✓ Sauvegarde supprimée")
		return true
	return false

# Récupère une valeur de la sauvegarde
func get_value(key: String, default = null):
	return current_save_data.get(key, default)

# Définit une valeur dans la sauvegarde (et sauvegarde immédiatement)
func set_value(key: String, value) -> bool:
	current_save_data[key] = value
	return save_game(current_save_data)

# Récupère toutes les données
func get_all_data() -> Dictionary:
	return current_save_data.duplicate()
