extends CharacterBody3D

@onready var anim = $AnimatedSprite3D
@onready var dialogue_display = $CanvasLayer/Control/Dialogue
@onready var hacking_minigame = load("res://scenes/computer.tscn")
@export var chef_dialogues: Dialogues
@onready var dialogue_ui_text = $CanvasLayer/Control/Dialogue
var anim_states = ["bread", "eating", "mix"]
var counter: float
var dialogue: String
var initialized: bool
var last_dialogue: bool

func _physics_process(delta):
	counter += delta
	
	if Input.is_action_just_pressed("f"):
		if initialized:
			anim.play("talk")
			if chef_dialogues.current_index <= chef_dialogues.dialogues.size()-1:
				dialogue = Manager.get_next_dialogue()
				display_ui(dialogue)
				chef_dialogues.current_index += 1	
				Manager.advice = ""
			else:
				dialogue_display.visible = false
				await get_tree().create_timer(2).timeout
				get_tree().change_scene_to_packed(hacking_minigame)
			
	if int(counter) % 5 == 0:
		anim.play(anim_states.pick_random())
		counter += 1.0
	
func _on_area_3d_body_entered(body):
	if body.name == "Player":
		if not Manager.bakery_pc_fixed:
			Manager.current_character = "chef"
			Manager.init()
			initialized = true
			display_ui("[color=#FFBF00]PRESS [F] TO CHAT[/color]")
		else:
			display_ui("[rainbow]Awesome! Now you can continue your shopping spree on the supermarket, I'll def go to your party[/rainbow]")

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		initialized = false
		hide_display()

func display_ui(text:String):
	dialogue_ui_text.visible = true
	var starter_text: String = "[center][wave][color=#7c9ca8]THE CHEF:[/color] "
	var ender_text: String =  " [color=#8cac94]∇[/color] [/wave][/center]"
	dialogue_display.text = starter_text + text + ender_text

func hide_display():
	dialogue_ui_text.visible = false
