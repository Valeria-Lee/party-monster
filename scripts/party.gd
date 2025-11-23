extends Node3D

@onready var timer = Timer.new()
@onready var party_countdown = $UI/TImerLabel
var party_time_text = "[right][rainbow]Party protocol activated!\nThe countdown to maximum fun has begun: "
@onready var word_spawner = $UI/WordSpawner
@onready var word_label = $UI/WordSpawner/WordLabel
var attack_words = ["AWKWARD DANCE MOVE","TICKLES","MERGE CONFLICT MAYHEM","POWER OF FRIENDSHIP","INFINITE LOOP KICK"]
var play_combat: bool = false
var win: bool = false
var rounds_won: int = 0

func _ready() -> void:
	add_child(timer)
	timer.wait_time = 10.0 # subir a 20
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	var rng = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	if not timer.is_stopped():
		var time = int(timer.time_left)
		var seconds = time % 60
		party_countdown.text = party_time_text + " " + str(seconds)
	else:
		if play_combat and rounds_won < 3:
			pass
			

func _on_timer_timeout():
	party_countdown.visible = false
	
	# aqui viene el policia a hablar contigo hija
	# esta es la pelea hija
	play_combat = true
	
func generate_random_word():
	var selected_word = attack_words.pick_random()
	word_label.text = selected_word
	attack_words.erase(selected_word)
	print(attack_words)
	
func change_word_position():
	var limited_expand_x_area = 1152 - word_label.size.x
	var limited_expand_y_area = 648 - word_label.size.y
	var x_coord = randi_range(0,limited_expand_x_area)
	var y_coord = randi_range(0,limited_expand_y_area)
	var random_coords = Vector2(x_coord, y_coord)
	word_label.position = random_coords

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			var key_name = OS.get_keycode_string(event.keycode)
			print(key_name)

func play_game():
	generate_random_word()
	change_word_position()
