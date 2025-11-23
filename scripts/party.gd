extends Node3D

@onready var timer = Timer.new()
@onready var party_countdown = $UI/TImerLabel
var party_time_text = "[right][rainbow]Party protocol activated!\nThe countdown to maximum fun has begun: "
@onready var word_spawner = $UI/WordSpawner
@onready var word_label = $UI/WordSpawner/WordLabel
var attack_words = ["AWKWARD-DANCE-MOVE","TICKLES","MERGE-CONFLICT-MAYHEM","POWER-OF-FRIENDSHIP","INFINITE-LOOP-KICK"]
@onready var rng = RandomNumberGenerator.new()
var play_combat: bool = false
var win: bool = false
var rounds_won: int = 0
var current_word
var selected_word: String = ""
var playing: bool = false

func _ready() -> void:
	add_child(timer)
	timer.wait_time = 5.0 # subir a 20
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _process(_delta: float) -> void:
	if not timer.is_stopped():
		var time = int(timer.time_left)
		var seconds = time % 60
		party_countdown.text = party_time_text + " " + str(seconds)

func _on_timer_timeout():
	party_countdown.visible = false
	
	# aqui viene el policia a hablar contigo hija
	
	# esta es la pelea hija
	play_combat = true
	play_game()
	
func generate_random_word():
	selected_word = attack_words.pick_random()
	print(selected_word)
	word_label.text = selected_word
	current_word = selected_word.split("")
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
			
			if play_combat:
				if current_word.is_empty():
					return
					
				var typed_char = ""
				
				if key_name == "Minus":
					typed_char = "-"
				else:
					typed_char = char(event.unicode).to_upper()
					
				if typed_char == current_word[0]:
					current_word.remove_at(0)
					print(current_word)
				
				if len(current_word) == 0:
					rounds_won += 1
					attack_words.erase(selected_word)
					play_game()

func play_game():
	if play_combat and rounds_won < 3:
		generate_random_word()
		change_word_position()
