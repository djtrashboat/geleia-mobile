extends Node2D

onready var time_start = OS.get_unix_time()
onready var time_elapsed = 0

var area0 = Vector2(192.0, 108.0)
var area1 = Vector2(576.0, 108.0)
var area2 = Vector2(960.0, 108.0)
var area3 = Vector2(960.0, 324.0)
var area4 = Vector2(576.0, 324.0)
var area5 = Vector2(192.0, 324.0)
var area6 = Vector2(192.0, 540.0)
var area7 = Vector2(576.0, 540.0)
var area8 = Vector2(960.0, 540.0)
var area_secreta = Vector2(192.0, 756.0)
var area_final = Vector2(576.0, 756.0)
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _process(delta: float) -> void:
	if $Player.position.y<216:
		time_elapsed = OS.get_unix_time() - time_start
		if $Player.position.x < 384.0 and $Player.position.x>0:
			$Camera2D.set_position(area0)
		elif $Player.position.x < 768.0 and $Player.position.x>384.0:
			$Camera2D.set_position(area1)
		elif $Player.position.x < 1152.0 and $Player.position.x>768.0:
			$Camera2D.set_position(area2)
		elif $Player.position.x<0:
			$Camera2D.set_position(area_secreta)
	elif $Player.position.y<432:
		time_elapsed = OS.get_unix_time() - time_start
		if $Player.position.x < 384.0 and $Player.position.x>0:
			$Camera2D.set_position(area5)
		elif $Player.position.x < 768.0 and $Player.position.x>384.0:
			$Camera2D.set_position(area4)
		elif $Player.position.x < 1152.0 and $Player.position.x>768.0:
			$Camera2D.set_position(area3)
	elif $Player.position.y<648:
		time_elapsed = OS.get_unix_time() - time_start
		if $Player.position.x < 384.0 and $Player.position.x>0:
			$Camera2D.set_position(area6)
		elif $Player.position.x < 768.0 and $Player.position.x>384.0:
			$Camera2D.set_position(area7)
		elif $Player.position.x < 1152.0 and $Player.position.x>768.0:
			$Camera2D.set_position(area8)
	elif $Player.position.y>648:
		$Camera2D.set_position(area_final)
	$Camera2D/tempo.set_text("time: " + String(time_elapsed))
