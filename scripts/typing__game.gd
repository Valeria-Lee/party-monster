extends Control

@onready var target_text = $CanvasLayer/UIRoot/TargetTextContainer/TargetText
@onready var text_edit = $CanvasLayer/UIRoot/TextEditContainer/TextEdit

var word_list = [
	"programacion", "godot", "juego", "mecanografia", "computadora",
	"teclado", "velocidad", "practica", "codigo", "desarrollo",
	"engine", "nodos", "escena", "script", "funcion", "instancia",
	"paquete", "modulo", "editor", "herramienta", "interfaz", "rendimiento"
]

# Called when tode enters the scene tree for the first time.
func _ready() -> void:
	#target_text.text = generate_random_text()
	text_edit.grab_focus()
	print(target_text.text)
	
	
func generate_random_text() -> String:
	var text = ''
	var word_count = 25
	
	for i in range(word_count):
		if i > 0:
			text += " "
		text += word_list[randi() % word_list.size()]	
	
	return text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
