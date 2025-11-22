extends Control

@onready var target_text = $CanvasLayer/UIRoot/TargetTextContainer/TargetText
@onready var text_edit = $CanvasLayer/UIRoot/TextEditContainer/TextEdit

var text = "Computer science isn't about computers, much like astronomy isn't about telescopes. The computer was born to solve problems that did not exist before. " \
  			+ "One machine can do the work of fifty ordinary men. No machine can do the work of one extraordinary man"

# Called when tode enters the scene tree for the first time.
func _ready() -> void:
	text_edit.grab_focus()
	print(target_text.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
