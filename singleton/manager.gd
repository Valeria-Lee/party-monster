extends Node

var current_character: String
var current_scene
var dialogues: Dialogues
var advice: String
@onready var chef_dialogues = load("res://dialogue/chef_dialogues.tres")
@onready var bakery = load("res://scenes/bakery.tscn")
var bakery_pc_fixed: bool

func init():
	match current_character:
		"chef":
			dialogues = chef_dialogues
			current_scene = bakery
			
func get_next_dialogue() -> String:
	return dialogues.dialogues[dialogues.current_index]
