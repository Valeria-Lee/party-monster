extends Control

var isOpen: bool
@onready var slots = $NinePatchRect/GridContainer.get_children()
@onready var item_display = $MarginContainer/ItemSprite
@onready var inv: Inventory = load("res://inventory/player_inventory.tres")

func _ready():
	visible = false
	inv.update.connect(update_ui)

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if isOpen == false:
			visible = true
			isOpen = true
		else:
			visible = false
			isOpen = false

func update_ui():
	for i in range(inv.items.size()):
		if inv.items[i] != null:
			slots[i].get_child(3).get_child(0).texture = inv.items[i].item.texture
			slots[i].get_child(2).text = str(inv.items[i].amount)
