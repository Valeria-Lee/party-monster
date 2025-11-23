extends Node

var current_character: String
var current_scene
var dialogues: Dialogues
var advice: String
@onready var chef_dialogues = load("res://dialogue/chef_dialogues.tres")
@onready var bakery = load("res://scenes/bakery.tscn")
@onready var star_dialogues = load("res://dialogue/star_dialogues.tres")
@onready var supermarket = load("res://scenes/supermarket.tscn")
var bakery_pc_fixed: bool
var supermarket_fixed: bool

func init():
	match current_character:
		"chef":
			dialogues = chef_dialogues
			current_scene = bakery
		"star":
			dialogues = star_dialogues
			current_scene = supermarket
			
func get_next_dialogue() -> String:
	return dialogues.dialogues[dialogues.current_index]
