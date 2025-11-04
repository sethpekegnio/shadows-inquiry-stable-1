extends Node

static func generer(role: String) -> Dictionary:
	var genre = "male" if randi() % 2 == 0 else "female"
	
	var prenoms_m = ["Jean", "Luc", "Paul", "Marc", "Pierre", "Thomas"]
	var prenoms_f = ["Marie", "Sophie", "Emma", "Julie", "Claire", "Léa"]
	var noms = ["Dupont", "Martin", "Durand", "Lefèvre", "Moreau", "Bernard", "Petit"]
	
	var prenom = prenoms_m[randi() % prenoms_m.size()] if genre == "male" else prenoms_f[randi() % prenoms_f.size()]
	var nom = noms[randi() % noms.size()]
	
	return {
		"role": role,
		"genre": genre,
		"prenom": prenom,
		"nom": nom,
		"cheveux_style": ["court", "mi-long", "long"][randi() % 3],
		"cheveux_couleur": ["noir", "brun", "blond", "roux"][randi() % 4],
		"barbe": "courte" if genre == "male" and randi() % 2 == 0 else "",
		"stats": {
			"Violence": randi_range(1, 10),
			"Empathie": randi_range(1, 10),
			"Intuition": randi_range(1, 10)
		}
	}
