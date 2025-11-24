extends Node

var inventory: Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory = load("res://inventory/player_inventory.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
