extends Control

@onready var input_display = $CanvasLayer/UIRoot/InputConsole
@onready var console_display = $CanvasLayer/UIRoot/DisplayConsole
@onready var input_terminal = $CanvasLayer/UIRoot/InputConsole/TextEdit
@onready var display_word_terminal = $CanvasLayer/UIRoot/DisplayConsole/VBoxContainer/RichTextLabel
@onready var hacking_ui = $CanvasLayer/UIRoot
@onready var starting_computer = $SplashScreen
@onready var win_label = $CanvasLayer/UIRoot/DisplayConsole/VBoxContainer/WinRounds
@onready var win_screen = $WinScreen
@onready var password_node = $PasswordField
@onready var password_text_edit = $PasswordField/TextEdit
@onready var password_label = $WinScreen/VBoxContainer/PasswordLabel
@onready var bakery = load("res://scenes/bakery.tscn")
# @onready var supermarket = load()
var input_display_open: bool = false
var console_display_open: bool = false
var starter_rich_label = "[center][shake]"
var game_words: Array[String] = ["51DEW4LK", "D15T0PY4", "4RT1F1C14L", "4N5W3R", "BYT3", "3L3CTR0"]
var counter: float
var playing: bool
var not_chosen: bool
var chosen_word: String
var rounds_win: int = 0
var current_password: String = "CUPC4K3"

func _ready():
	not_chosen = true
	playing = true

func _physics_process(delta):
	counter += delta
	
	if int(counter) < 4:
		starting_computer.visible = true
		hacking_ui.visible = false
	else:
		starting_computer.visible = false
		hacking_ui.visible = true
		
		hacking_game()
	
	check_password()

func _on_input_app_button_pressed():
	if input_display_open:
		change_input(false)
		input_display_open = false
		input_terminal.text = ""
	else:
		change_input(true)
		input_display_open = true
		change_display(false)
		console_display_open = false

func _on_display_app_button_pressed():
	if console_display_open:
		change_display(false)
		console_display_open = false
	else:
		change_display(true)
		console_display_open = true
		change_input(false)
		input_terminal.text = ""
		input_display_open = false
		
func change_word():
	var random_characters: Array[String] = ["*", ":)", "7", "5", "_", "##", "!"]
	var take_action: Array[String] = ["add_char", "mini"]	
	
func change_input(state: bool):
	input_display.visible = state
		
func change_display(state: bool):
	console_display.visible = state
	
func check_correct_answer(word: String):
	if input_terminal.text == word:
		rounds_win += 1
		input_terminal.text = ""
		not_chosen = true
		win_label.text = str(rounds_win) + "/3"
	
func check_win(rounds:int):
	if rounds == 3:
		change_display(false)
		change_input(false)
		win_screen.visible = true
		password_label.text = "[center]PASSWORD: " + current_password
		password_node.visible = true
		playing = false
		
func generate_word() -> String:
	chosen_word = game_words.pick_random()
	var index: int = game_words.find(chosen_word)
	game_words.pop_at(index)
	display_word_terminal.text = starter_rich_label + chosen_word
	not_chosen = false
	return chosen_word

func check_password():
	if password_text_edit.text == current_password:
		get_tree().change_scene_to_packed(Manager.current_scene)
		Manager.bakery_pc_fixed = true

func hacking_game():
	if playing:
		if not_chosen:
			generate_word()
		else:
			check_correct_answer(chosen_word)

	check_win(rounds_win)
