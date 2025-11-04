# res://systems/PNJGenerator.gd
extends Node

static func create(role: String) -> Dictionary:
    var is_male = randi() % 2 == 0
    var first_names = ["Jean", "Marie", "Luc", "Sophie", "Paul", "Emma"]
    var last_names = ["Dupont", "Martin", "Durand", "Lefèvre", "Moreau"]
    var hair_styles = ["court", "mi-long", "long", "chauve", "tresses"]
    var hair_colors = ["noir", "brun", "blond", "roux", "gris"]
    
    return {
        "role": role,
        "genre": "male" if is_male else "female",
        "prenom": first_names[randi() % first_names.size()],
        "nom": last_names[randi() % last_names.size()],
        "cheveux_style": hair_styles[randi() % hair_styles.size()],
        "cheveux_couleur": hair_colors[randi() % hair_colors.size()],
        "barbe": "courte" if is_male and randi() % 3 == 0 else "",
        "stats": {
            "Violence": randi_range(1, 10),
            "Empathie": randi_range(1, 10),
            "Intuition": randi_range(1, 10)
        }
    }