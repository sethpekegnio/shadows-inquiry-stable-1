extends Control

@onready var dialogue_panel = $DialoguePanel
@onready var dialogue_text = $DialoguePanel/VBox/DialogueText
@onready var choice_container = $DialoguePanel/VBox/ChoicesContainer
@onready var directeur_name = $DialoguePanel/VBox/DirecteurName

var current_question = 0
var questions = []

func _ready():
	print("🎤 Entretien d'embauche ready")
	_setup_questions()
	_show_next_question()

func _setup_questions():
	var directeur = Global.donnees_joueur.pnj.get("directeur", {})
	var nom_directeur = "%s %s" % [directeur.get("prenom", "Chef"), directeur.get("nom", "")]
	directeur_name.text = nom_directeur
	
	questions = [
		{
			"texte": "Bienvenue. Première question : Face à un suspect qui ment, comment réagissez-vous ?",
			"choix": [
				{"texte": "Je le mets sous pression physiquement", "stats": {"Violence": 2, "Karma": -1}},
				{"texte": "J'observe en silence pour détecter ses failles", "stats": {"Intuition": 2}},
				{"texte": "J'essaie de comprendre ses motivations", "stats": {"Empathie": 2, "Karma": 1}}
			]
		},
		{
			"texte": "Un collègue vous propose un pot-de-vin. Que faites-vous ?",
			"choix": [
				{"texte": "J'accepte pour l'enquête", "stats": {"Corruption": 1, "Ressources": 1}},
				{"texte": "Je refuse poliment", "stats": {"Karma": 1}},
				{"texte": "Je le dénonce immédiatement", "stats": {"Reputation": 2, "Allies": -1}}
			]
		},
		{
			"texte": "Vous découvrez une scène gore. Votre réaction ?",
			"choix": [
				{"texte": "Ça m'excite de traquer ce type", "stats": {"Violence": 1, "SanteMentale": -1}},
				{"texte": "J'analyse froidement les indices", "stats": {"Intuition": 2}},
				{"texte": "Ça me révulse mais je tiens bon", "stats": {"SanteMentale": -2, "Empathie": 1, "Resilience": 1}}
			]
		},
		{
			"texte": "Un allié vous trahit. Comment gérez-vous ça ?",
			"choix": [
				{"texte": "Je me venge", "stats": {"Violence": 2, "Allies": -2}},
				{"texte": "Je comprends et pardonne", "stats": {"Empathie": 2, "Karma": 1}},
				{"texte": "Je retourne ça contre lui", "stats": {"Intuition": 2, "Karma": -1}}
			]
		},
		{
			"texte": "Vous ratez une enquête importante. Que faites-vous ?",
			"choix": [
				{"texte": "Je me relève plus dur qu'avant", "stats": {"Resilience": 2}},
				{"texte": "J'analyse mes erreurs", "stats": {"Intuition": 2}},
				{"texte": "Je cherche du soutien", "stats": {"Allies": 2}}
			]
		},
		{
			"texte": "Dernière question : Sur le balcon de votre retraite, la ville vous juge. Que faites-vous ?",
			"choix": [
				{"texte": "Je la défie du regard", "stats": {"Violence": 2, "Karma": -1}},
				{"texte": "Je murmure un secret au vent", "stats": {"Intuition": 2}},
				{"texte": "Je tends la main aux ombres", "stats": {"Empathie": 2, "Karma": 2}}
			]
		}
	]

func _show_next_question():
	if current_question >= questions.size():
		_finish_interview()
		return
	
	var question = questions[current_question]
	dialogue_text.text = question.texte
	
	# Nettoyer anciens boutons
	for child in choice_container.get_children():
		child.queue_free()
	
	# Créer nouveaux boutons
	for i in range(question.choix.size()):
		var choix = question.choix[i]
		var btn = Button.new()
		btn.text = choix.texte
		btn.custom_minimum_size = Vector2(0, 50)
		btn.pressed.connect(_on_choice_selected.bind(i))
		choice_container.add_child(btn)

func _on_choice_selected(choice_index: int):
	var question = questions[current_question]
	var choix = question.choix[choice_index]
	
	# Appliquer modifications stats
	for stat_name in choix.stats:
		Global.modifier_stat(stat_name, choix.stats[stat_name])
	
	print("✓ Réponse %d à Q%d : %s" % [choice_index + 1, current_question + 1, choix.texte])
	
	current_question += 1
	_show_next_question()

func _finish_interview():
	print("✅ Entretien terminé")
	Global.donnees_joueur.entretien_termine = true
	Global.donnees_joueur.poste_obtenu = true
	Global.auto_sauvegarder()
	
	dialogue_text.text = "Parfait. Vous êtes engagé(e). Bienvenue dans l'équipe, inspecteur %s." % Global.donnees_joueur.last_name
	
	# Nettoyer choix
	for child in choice_container.get_children():
		child.queue_free()
	
	# Bouton continuer
	var btn_continue = Button.new()
	btn_continue.text = "Continuer"
	btn_continue.custom_minimum_size = Vector2(0, 60)
	btn_continue.pressed.connect(_on_continue)
	choice_container.add_child(btn_continue)

func _on_continue():
	get_tree().change_scene_to_file("res://systems/scenes/locations/Commissariat.tscn")
