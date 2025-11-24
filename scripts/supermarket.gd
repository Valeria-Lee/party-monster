extends Node3D

@onready var door = $Door
@onready var party_scene = load("res://scenes/party.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Manager.bakery_pc_fixed == true:
		door.visible = true

func _on_door_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_packed(party_scene)
