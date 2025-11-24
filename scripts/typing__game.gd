extends Control

@onready var target_text = $CanvasLayer/UIRoot/TargetTextContainer/TargetText
@onready var text_edit = $CanvasLayer/UIRoot/TextEditContainer/TextEdit
@onready var timer_label = $CanvasLayer/UIRoot/TimerLabel
@onready var target_text_container = $CanvasLayer/UIRoot/TargetTextContainer
@onready var text_edit_container = $CanvasLayer/UIRoot/TextEditContainer
@onready var lost_label = $CanvasLayer/UIRoot/LostLabel
@onready var win_label = $CanvasLayer/UIRoot/WinLabel
@onready var restart_label = $CanvasLayer/UIRoot/RestartLabel
@onready var timer = $Timer

var text = "Computer science isn't about computers, much like astronomy isn't about telescopes. The computer was born to solve problems that did not exist before. " \
  			+ "One machine can do the work of fifty ordinary men. No machine can do the work of one extraordinary man"

# Called when tode enters the scene tree for the first time.
func _ready() -> void:
	text_edit.grab_focus()
	target_text.text = text 
	lost_label.hide()
	win_label.hide()
	restart_label.hide()
	print(target_text.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not timer.is_stopped():
		var time = int(timer.time_left)
		var minutes = time / 60
		var seconds = time % 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]
		
func restart_game():
	# Reset UI
	lost_label.hide()
	restart_label.hide()

	target_text_container.show()
	text_edit_container.show()

	# Reset text
	text_edit.text = ""
	text_edit.grab_focus()
	input_locked = false

	# Restart timer
	timer.stop()
	timer.start()
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R and lost_label.visible:
			restart_game()

func show_loss():
	target_text_container.hide()
	text_edit_container.hide()
	lost_label.show()
	restart_label.show()

func _on_timer_timeout() -> void:
	# Show loss screen 
	show_loss()

func show_victory():
	timer.stop()
	# Show victory screen
	target_text_container.hide()
	text_edit_container.hide()
	win_label.show()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_packed(Manager.current_scene)
	Manager.supermarket_fixed = true 
	
var input_locked = false 

func validate_text():
	var user_input = text_edit.text
	var reference = text
	var has_error = false

	var length = user_input.length()

	for i in range(length):
		var user_char = user_input[i]
		var ref_char = reference[i]

		if has_error:
			has_error = true
		else:
			if user_char == ref_char:
				# Correct 
				pass 
			else:
				# Incorrect character 
				has_error = true
		
	
	input_locked = has_error
	
	# Verify victory
	if not has_error and user_input == reference:
		show_victory()

func _on_text_edit_text_changed() -> void:
	validate_text()

func _on_text_edit_gui_input(event: InputEvent) -> void:	
	if input_locked:
		if event is InputEventKey:
			# Allow only Backspace
			if event.pressed and event.keycode != KEY_BACKSPACE:
				# Cancel input 
				accept_event()  
