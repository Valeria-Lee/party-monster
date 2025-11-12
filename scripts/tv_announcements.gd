extends StaticBody3D

@onready var display_label = $SubViewport/Control/MarginContainer/RichTextLabel
var quotes = ["buy more\n cookies", "we are\nwatching\nyou", "new\ncupcake\nflavor", "ask chef\nabout new\npastries"]
var counter: float
var chosen_quote: String
var chosen_quote_size: int
var starter_text: String = "[center]"

func _ready():
	display_label.text = starter_text

func _process(delta):
	counter += delta
	var i:int = 0
	
	if int(counter) % 10 == 0:
		chosen_quote = quotes.pick_random()
		
		display_label.text = starter_text + chosen_quote
		
		counter += 1.0
