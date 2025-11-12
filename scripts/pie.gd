extends Area3D

@export var item: Item
var player

func _on_body_entered(body):
	if body.name == 'Player':
		player = body

func _on_body_exited(body):
	if body.name == 'Player':
		player = null
		
func _process(_delta):
	if Input.is_action_just_pressed("e") and player != null:
		player.collect_item(item)
