extends Node3D

@onready var door = $Door
@onready var supermarket_scene = load("res://scenes/supermarket.tscn")

func _physics_process(delta: float) -> void:
	if Manager.bakery_pc_fixed == true:
		door.visible = true
	
func _on_door_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		print("hola mi nombre es aime")
		get_tree().change_scene_to_packed(supermarket_scene)
