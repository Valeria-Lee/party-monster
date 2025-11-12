extends StaticBody3D

var can_pay: bool
var player
var payment: int

func _ready():
	payment = 100 - Money.money
	$SubViewport/Label.text = str(payment)
	
func _process(delta):
	payment = 100 - Money.money
	$SubViewport/Label.text = str(payment)

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		can_pay = true
		player = body

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		can_pay = false
		player = null
