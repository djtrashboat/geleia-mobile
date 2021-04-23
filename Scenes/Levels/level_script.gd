extends Node2D

onready var time_start = OS.get_unix_time()
onready var time_elapsed = 0

var LevelMenu = "res://Scenes/menu/LevelMenu.tscn"

export var total_time = 120
var time_remaining =120

var area0 = Vector2(216.0, 108.0)
var area1 = Vector2(216.0 + 432.0, 108.0)
var area2 = Vector2(216.0 + 2*432.0, 108.0)
var area3 = Vector2(216.0 + 3*432.0, 108.0)
var area4 = Vector2(216.0 + 4*432.0, 108.0)
var area5 = Vector2(216.0 + 5*432.0, 108.0)
var area6 = Vector2(216.0 + 6*432.0, 108.0)
var area7 = Vector2(216.0 + 7*432.0, 108.0)
var area8 = Vector2(216.0 + 8*432.0, 108.0)


func _process(delta: float) -> void:
	if $Player.position.x < 432.0 and $Player.position.x>0:
		$Camera2D.set_position(area0)
	elif $Player.position.x < 2*432.0 and $Player.position.x>384.0:
		$Camera2D.set_position(area1)
	elif $Player.position.x < 3*432.0 and $Player.position.x>768.0:
		$Camera2D.set_position(area2)
	elif $Player.position.x < 4*432.0 and $Player.position.x>0:
		$Camera2D.set_position(area3)
	elif $Player.position.x < 5*432.0 and $Player.position.x>0:
		$Camera2D.set_position(area4)
	elif $Player.position.x < 6*432.0 and $Player.position.x>0:
		$Camera2D.set_position(area5)
	elif $Player.position.x < 7*432.0 and $Player.position.x>0:
		$Camera2D.set_position(area6)
	elif $Player.position.x < 8*432.0 and $Player.position.x>0:
		$Camera2D.set_position(area7)
	elif $Player.position.x < 9*432.0 and $Player.position.x>0:
		$Camera2D.set_position(area8)
	time_elapsed = OS.get_unix_time() - time_start
	time_remaining = total_time - time_elapsed
	#$ontop/Label.set_text(String(time_remaining/60))
	#$ontop/Label.text += ":" + String("%02d" % (time_remaining%60))
	$ontop/Label.text = (String(time_remaining/60)) +":" + String("%02d" % (time_remaining%60))
	if (time_remaining- time_elapsed)<0:
		print("acabou o tempo")
		set_process(false)
		get_tree().change_scene(LevelMenu)
