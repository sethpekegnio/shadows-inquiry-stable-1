# res://systems/scripts/ItemDatabase.gd
# Base de données des objets - Version propre et testée
class_name ItemDatabase
extends Resource

# ===== BASE DE DONNÉES : 20 OBJETS =====
static func get_all_items() -> Array:
    return [
        # ARMES (5)
        {
            "id": "weapon_knife",
            "name": "Couteau",
            "price": 30,
            "category": "weapon",
            "icon": "🔪",
            "description": "Couteau de cuisine standard.\nDiscret et efficace.",
            "actions": {
                "on_pnj": ["Menacer", "Poignarder", "Blesser"],
                "on_object": ["Couper", "Graver"],
                "on_self": ["Examiner", "Nettoyer"]
            }
        },
        {
            "id": "weapon_pistol",
            "name": "Pistolet 9mm",
            "price": 500,
            "category": "weapon",
            "icon": "🔫",
            "description": "Arme de poing.\n15 balles.",
            "actions": {
                "on_pnj": ["Menacer", "Tirer", "Exécuter"],
                "on_object": ["Détruire"],
                "on_self": ["Recharger", "Nettoyer"]
            }
        },
        {
            "id": "weapon_taser",
            "name": "Taser",
            "price": 200,
            "category": "weapon",
            "icon": "⚡",
            "description": "Neutralise 30 secondes.\nNon létal.",
            "actions": {
                "on_pnj": ["Neutraliser", "Interroger"],
                "on_object": ["Court-circuiter"],
                "on_self": ["Tester charge"]
            }
        },
        {
            "id": "weapon_baton",
            "name": "Matraque",
            "price": 80,
            "category": "weapon",
            "icon": "🪓",
            "description": "Métal renforcé.\nImpact violent.",
            "actions": {
                "on_pnj": ["Frapper", "Assommer", "Intimider"],
                "on_object": ["Briser"],
                "on_self": ["Ranger"]
            }
        },
        {
            "id": "weapon_syringe",
            "name": "Seringue Poison",
            "price": 300,
            "category": "weapon",
            "icon": "💉",
            "description": "Cyanure concentré.\nMort rapide.",
            "actions": {
                "on_pnj": ["Injecter", "Tuer"],
                "on_object": ["Contaminer"],
                "on_self": ["Ranger"]
            }
        },
        
        # CHIMIE (5)
        {
            "id": "chem_bleach",
            "name": "Eau de Javel",
            "price": 5,
            "category": "chemical",
            "icon": "🧪",
            "description": "Nettoyant puissant.\nDétruit ADN.",
            "actions": {
                "on_pnj": ["Aveugler", "Empoisonner"],
                "on_object": ["Nettoyer sang", "Effacer traces"],
                "on_self": ["Utiliser"]
            }
        },
        {
            "id": "chem_acid",
            "name": "Acide",
            "price": 50,
            "category": "chemical",
            "icon": "⚗️",
            "description": "Dissout matière organique.\nDangereux.",
            "actions": {
                "on_pnj": ["Torturer", "Dissoudre"],
                "on_object": ["Détruire", "Graver"],
                "on_self": ["Manipuler"]
            }
        },
        {
            "id": "chem_poison",
            "name": "Poison",
            "price": 200,
            "category": "chemical",
            "icon": "☠️",
            "description": "Mort-aux-rats.\nMortel.",
            "actions": {
                "on_pnj": ["Empoisonner"],
                "on_object": ["Contaminer nourriture"],
                "on_self": ["Doser"]
            }
        },
        {
            "id": "chem_chloroform",
            "name": "Chloroforme",
            "price": 80,
            "category": "chemical",
            "icon": "😴",
            "description": "Anesthésiant rapide.\n30 sec effet.",
            "actions": {
                "on_pnj": ["Endormir", "Kidnapper"],
                "on_object": ["Imbiber chiffon"],
                "on_self": ["Utiliser"]
            }
        },
        {
            "id": "chem_gasoline",
            "name": "Essence",
            "price": 10,
            "category": "chemical",
            "icon": "⛽",
            "description": "Inflammable.\nAccélérateur.",
            "actions": {
                "on_pnj": ["Brûler"],
                "on_object": ["Incendier", "Détruire preuves"],
                "on_self": ["Stocker"]
            }
        },
        
        # OUTILS (5)
        {
            "id": "tool_gloves",
            "name": "Gants Latex",
            "price": 3,
            "category": "tool",
            "icon": "🧤",
            "description": "Boîte de 100.\nPas d'empreintes.",
            "actions": {
                "on_pnj": ["Porter avant crime"],
                "on_object": ["Manipuler sans traces"],
                "on_self": ["Enfiler", "Jeter"]
            }
        },
        {
            "id": "tool_tape",
            "name": "Ruban Adhésif",
            "price": 8,
            "category": "tool",
            "icon": "📼",
            "description": "Ruban résistant.\nPolyvalent.",
            "actions": {
                "on_pnj": ["Bâillonner", "Ligoter"],
                "on_object": ["Attacher", "Sceller"],
                "on_self": ["Utiliser"]
            }
        },
        {
            "id": "tool_rope",
            "name": "Corde",
            "price": 12,
            "category": "tool",
            "icon": "🪢",
            "description": "10m nylon.\nRésistant.",
            "actions": {
                "on_pnj": ["Ligoter", "Pendre"],
                "on_object": ["Attacher"],
                "on_self": ["Nouer"]
            }
        },
        {
            "id": "tool_lockpick",
            "name": "Kit Crochetage",
            "price": 150,
            "category": "tool",
            "icon": "🔓",
            "description": "Outils pro.\n10 usages.",
            "actions": {
                "on_pnj": ["Déverrouiller menottes"],
                "on_object": ["Crocheter porte", "Forcer serrure"],
                "on_self": ["Utiliser"]
            }
        },
        {
            "id": "tool_crowbar",
            "name": "Pied de Biche",
            "price": 35,
            "category": "tool",
            "icon": "🪛",
            "description": "Outil/arme.\nForce brute.",
            "actions": {
                "on_pnj": ["Frapper"],
                "on_object": ["Forcer porte", "Briser"],
                "on_self": ["Porter"]
            }
        },
        
        # TECH (3)
        {
            "id": "tech_camera",
            "name": "Caméra Espion",
            "price": 250,
            "category": "tech",
            "icon": "📷",
            "description": "Mini-caméra HD.\nDiscrète.",
            "actions": {
                "on_pnj": ["Surveiller", "Photographier"],
                "on_object": ["Installer", "Filmer"],
                "on_self": ["Visionner"]
            }
        },
        {
            "id": "tech_phone",
            "name": "Téléphone Jetable",
            "price": 30,
            "category": "tech",
            "icon": "📱",
            "description": "Prépayé.\nIntraçable.",
            "actions": {
                "on_pnj": ["Appeler"],
                "on_object": ["Communiquer"],
                "on_self": ["Détruire"]
            }
        },
        {
            "id": "tech_gps",
            "name": "Traceur GPS",
            "price": 120,
            "category": "tech",
            "icon": "📍",
            "description": "Temps réel.\nMagnétique.",
            "actions": {
                "on_pnj": ["Tracer"],
                "on_object": ["Coller sur véhicule"],
                "on_self": ["Suivre"]
            }
        },
        
        # DIVERS (2)
        {
            "id": "misc_cash",
            "name": "Liasse Billets",
            "price": 0,
            "category": "misc",
            "icon": "💵",
            "description": "10 000$ liquide.\nNon traçable.",
            "actions": {
                "on_pnj": ["Soudoyer", "Payer"],
                "on_object": ["Planquer"],
                "on_self": ["Compter"]
            }
        },
        {
            "id": "misc_fake_id",
            "name": "Faux Papiers",
            "price": 500,
            "category": "misc",
            "icon": "🪪",
            "description": "ID + permis.\nQualité pro.",
            "actions": {
                "on_pnj": ["Se faire passer pour"],
                "on_object": ["Montrer"],
                "on_self": ["Utiliser"]
            }
        }
    ]

# Récupérer un item par ID
static func get_item_by_id(item_id: String) -> Dictionary:
    var items = get_all_items()
    for item in items:
        if item.id == item_id:
            return item
    return {}

# Récupérer items par catégorie
static func get_items_by_category(cat: String) -> Array:
    var items = get_all_items()
    var result = []
    for item in items:
        if item.category == cat:
            result.append(item)
    return result

# Récupérer items aléatoires
static func get_random_items(count: int) -> Array:
    var items = get_all_items()
    items.shuffle()
    var max_count = min(count, items.size())
    return items.slice(0, max_count)
