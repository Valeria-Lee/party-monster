extends StaticBody3D

var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e") and player != null:
		player.pay()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player = body

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player = null
