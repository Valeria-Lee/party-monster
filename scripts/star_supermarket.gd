extends CharacterBody3D

@onready var dialogue_display = $CanvasLayer/Control/Dialogue
@onready var hacking_minigame = load("res://scenes/typing_game.tscn")
@export var star_dialogues: Dialogues
@onready var dialogue_ui_text = $CanvasLayer/Control/Dialogue
var dialogue: String
var initialized: bool
var last_dialogue: bool

func _physics_process(_delta):	
	if Input.is_action_just_pressed("f"):
		if initialized:
			if star_dialogues.current_index <= star_dialogues.dialogues.size()-1:
				dialogue = Manager.get_next_dialogue()
				display_ui(dialogue)
				star_dialogues.current_index += 1	
				Manager.advice = ""
			else:
				dialogue_display.visible = false
				await get_tree().create_timer(2).timeout
				get_tree().change_scene_to_packed(hacking_minigame)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		if not Manager.supermarket_fixed:
			Manager.current_character = "star"
			Manager.init()
			initialized = true
			display_ui("[color=#FFBF00]PRESS [F] TO CHAT[/color]")
		else:
			# ya gano este mf, ponle algo asi bonito
			display_ui("[rainbow][/rainbow]")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		initialized = false
		hide_display()

func display_ui(text:String):
	dialogue_ui_text.visible = true
	var starter_text: String = "[center][wave][color=#7c9ca8]STAR:[/color] "
	var ender_text: String =  " [color=#8cac94]∇[/color] [/wave][/center]"
	dialogue_display.text = starter_text + text + ender_text

func hide_display():
	dialogue_ui_text.visible = false
