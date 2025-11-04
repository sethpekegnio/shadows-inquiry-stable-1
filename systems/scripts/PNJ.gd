extends CharacterBody3D

# Données du PNJ
var data: Dictionary = {}

func _ready():
	if data.is_empty():
		print("⚠️ PNJ créé sans données")
		return
	
	print("👤 PNJ spawné : %s %s (Role: %s)" % [
		data.get("prenom", "???"),
		data.get("nom", "???"),
		data.get("role", "???")
	])
	
	# Trouver et CACHER le label (pas besoin de voir le nom au sol)
	var label = find_child("Label3D", true, false)
	if label and label is Label3D:
		label.visible = false  # Cacher le label
		var nom_complet = "%s %s" % [data.get("prenom", "???"), data.get("nom", "???")]
		print("  ✓ Label caché (nom: %s)" % nom_complet)
	
	# Stats
	if data.has("stats"):
		print("  Stats : V=%d E=%d I=%d" % [
			data.stats.get("Violence", 0),
			data.stats.get("Empathie", 0),
			data.stats.get("Intuition", 0)
		])
