extends CharacterBody3D

@onready var anim = $AnimatedSprite3D
@onready var dialogue_display = $CanvasLayer/Control/Dialogue
@onready var hacking_minigame = load("res://scenes/computer.tscn")
@export var chef_dialogues: Dialogues
var anim_states = ["bread", "eating", "mix"]
var counter: float
var dialogue: String
var initialized: bool
var last_dialogue: bool
var show_congratulations: bool

func _ready():
	show_congratulations = true

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
			
	if Manager.bakery_pc_fixed && show_congratulations:
		Manager.advice = "[center][rainbow]ACHIEVEMENT UNLOCKED: BAKERY'S PC FIXED"
		show_congratulations = false
			
	if int(counter) % 5 == 0:
		anim.play(anim_states.pick_random())
		counter += 1.0
	
func _on_area_3d_body_entered(body):
	if body.name == "Player":
		Manager.current_character = "chef"
		Manager.init()
		initialized = true
		if show_congratulations == false:
			Manager.advice = ""
		else:
			Manager.advice = "[center][wave][F]"

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		initialized = false
		Manager.advice = ""

func display_ui(dialogue:String):
	var starter_text: String = "[center][wave][color=#7c9ca8]THE CHEF:[/color] "
	var ender_text: String =  " [color=#8cac94]∇[/color] [/wave][/center]"
	dialogue_display.text = starter_text + dialogue + ender_text
