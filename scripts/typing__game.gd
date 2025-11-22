extends Control

@onready var target_text = $CanvasLayer/UIRoot/TargetTextContainer/TargetText
@onready var text_edit = $CanvasLayer/UIRoot/TextEditContainer/TextEdit
@onready var timer_label = $CanvasLayer/UIRoot/TimerLabel
@onready var timer = $Timer

var text = "Computer science isn't about computers, much like astronomy isn't about telescopes. The computer was born to solve problems that did not exist before. " \
  			+ "One machine can do the work of fifty ordinary men. No machine can do the work of one extraordinary man"

# Called when tode enters the scene tree for the first time.
func _ready() -> void:
	text_edit.grab_focus()
	print(target_text.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not timer.is_stopped():
		var time = int(timer.time_left)
		var minutes = time / 60
		var seconds = time % 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]
