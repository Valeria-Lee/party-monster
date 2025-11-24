extends Area3D

var can_pay: bool
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e") and player != null:
		player.pay()

func _on_body_entered(body):
	if body.name == "Player":
		can_pay = true
		player = body

func _on_body_exited(body):
	if body.name == "Player":
		can_pay = false
		player = null
