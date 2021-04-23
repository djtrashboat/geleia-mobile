extends Node2D

export (int) var level
export (String) var level_to_load

onready var level_label = $TouchScreenButton/Label

func setup():
	level_label.text = String(level)


func _ready() -> void:
	setup()



func _on_TouchScreenButton_pressed() -> void:
	get_tree().change_scene(level_to_load)
	#print("clicked button:", level)
