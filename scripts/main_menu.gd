extends Node3D

@onready var announcement_scene = load("res://scenes/announcements.tscn")

func _on_play_btn_button_down() -> void:
	get_tree().change_scene_to_packed(announcement_scene)
