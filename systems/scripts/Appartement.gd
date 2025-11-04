extends Node2D

@onready var label = $ColorRect/Label

var chemin_save = "user://sauvegarde.json"

func _ready():
	print("Appartement 2D chargé (scène legacy - non utilisée)")
	
	if not label:
		push_error("Label introuvable")
		return
	
	label.text = "Appartement 2D - Scène non utilisée\n"
	
	# Chargement sauvegarde si elle existe
	if FileAccess.file_exists(chemin_save):
		var fichier = FileAccess.open(chemin_save, FileAccess.READ)
		if fichier:
			var json_text = fichier.get_as_text()
			fichier.close()
			
			var json = JSON.new()
			var result = json.parse(json_text)
			
			if result == OK:
				var donnees = json.data
				if donnees.has("sexe") and donnees.has("age"):
					label.text += "Inspecteur %s, %d ans" % [donnees.sexe, donnees.age]
			else:
				push_error("Erreur parsing JSON sauvegarde")
