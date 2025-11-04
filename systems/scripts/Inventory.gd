extends Node

# ===== SINGLETON INVENTAIRE =====

const MAX_SLOTS = 10

var items = []  # Array de Dictionaries
var selected_slot = -1  # -1 = aucun sélectionné
var held_item_visual: Node3D = null  # Référence à l'objet 3D tenu en main

signal item_added(item: Dictionary, slot: int)
signal item_removed(slot: int)
signal slot_selected(slot: int, item: Dictionary)
signal item_used(item: Dictionary, target)
signal carnet_opened()
signal held_item_changed(item: Dictionary)

func _ready():
	print("=== INVENTORY SYSTEM INITIALIZED ===")
	# Init slots vides
	for i in range(MAX_SLOTS):
		items.append(null)
	
	# Slot 1 (index 1) = Carnet fixe
	items[1] = {
		"id": "carnet",
		"name": "Carnet d'Enquêteur",
		"icon": null,
		"actions": ["open"],
		"type": "special",
		"locked": true
	}

func add_item(item: Dictionary, slot: int = -1) -> bool:
	# Slot 1 réservé au carnet
	if slot == 1:
		return false
	
	# Si slot spécifié
	if slot >= 0 and slot < MAX_SLOTS:
		if items[slot] == null:
			items[slot] = item
			item_added.emit(item, slot)
			print("Item added to slot %d: %s" % [slot, item.name])
			return true
		else:
			print("Slot %d already occupied" % slot)
			return false
	
	# Sinon, chercher premier slot vide (skip slot 1)
	for i in range(MAX_SLOTS):
		if i == 1:
			continue
		if items[i] == null:
			items[i] = item
			item_added.emit(item, i)
			print("Item added to slot %d: %s" % [i, item.name])
			return true
	
	print("Inventory full!")
	return false

func remove_item(slot: int) -> Dictionary:
	# Slot 1 non supprimable
	if slot == 1:
		return {}
	
	if slot >= 0 and slot < MAX_SLOTS and items[slot] != null:
		var item = items[slot]
		items[slot] = null
		item_removed.emit(slot)
		print("Item removed from slot %d" % slot)
		if selected_slot == slot:
			selected_slot = -1
		return item
	return {}

func get_item(slot: int) -> Dictionary:
	if slot >= 0 and slot < MAX_SLOTS:
		return items[slot] if items[slot] != null else {}
	return {}

func select_slot(slot: int):
	if slot >= 0 and slot < MAX_SLOTS:
		selected_slot = slot
		var item = items[slot]
		
		slot_selected.emit(slot, item if item != null else {})
		
		if item:
			print("Selected: %s (Slot %d)" % [item.name, slot])
			held_item_changed.emit(item)
		else:
			print("Selected empty slot %d" % slot)
			held_item_changed.emit({})
		
		# Si slot 1 (carnet), émettre signal
		if slot == 1:
			carnet_opened.emit()

func get_selected_item() -> Dictionary:
	if selected_slot >= 0:
		return items[selected_slot] if items[selected_slot] != null else {}
	return {}

func use_selected_item(target = null):
	var item = get_selected_item()
	if item:
		print("Using: %s" % item.name)
		item_used.emit(item, target)
		return true
	return false

func has_item(item_id: String) -> bool:
	for item in items:
		if item and item.get("id") == item_id:
			return true
	return false

func get_item_count(item_id: String) -> int:
	var count = 0
	for item in items:
		if item and item.get("id") == item_id:
			count += 1
	return count

# Preset items
func create_knife() -> Dictionary:
	return {
		"id": "knife",
		"name": "Knife",
		"icon": null,
		"actions": ["threaten", "stab_belly", "stab_throat", "stab_leg", "cut"],
		"damage": 50,
		"type": "weapon"
	}

func create_gun() -> Dictionary:
	return {
		"id": "gun",
		"name": "Service Gun",
		"icon": null,
		"actions": ["threaten", "shoot_kill", "shoot_wound"],
		"damage": 100,
		"ammo": 15,
		"type": "weapon"
	}

func create_badge() -> Dictionary:
	return {
		"id": "badge",
		"name": "Detective Badge",
		"icon": null,
		"actions": ["show", "use"],
		"type": "item"
	}
