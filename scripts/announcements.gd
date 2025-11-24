extends Control

@onready var announcements_label = $CanvasLayer/RichTextLabel
@onready var bakery_scene = load("res://scenes/bakery.tscn")

func _process(_delta: float) -> void:
	if not Manager.bakery_pc_fixed:
		announcements_label.text = "3012. Earth, Unknown Territory.\nIn a world where every single movement is tracked, our protagonist, _____, must engineer an escape. Her revolutionary plan? Throwing a party!\nBut first, she needs to hit the bakery and the grocery store"
		await get_tree().create_timer(10).timeout
		get_tree().change_scene_to_packed(bakery_scene)
	if Manager.bakery_pc_fixed and Manager.party_defeated:
		announcements_label.text = "[wave]Wowza! You did it.\nYou escaped. Finally... Finally?"
