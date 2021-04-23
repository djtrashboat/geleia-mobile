extends Node2D

func _process(delta: float) -> void:
	if get_node("rightbutton").is_pressed():
		Input.action_press("move_right")
	if get_node("leftbutton").is_pressed():
		Input.action_press("move_left")


func _on_rightbutton_pressed() -> void:
	Input.action_press("move_right")


func _on_rightbutton_released() -> void:
	Input.action_release("move_right")

func _on_leftbutton_pressed() -> void:
	Input.action_press("move_left")

func _on_leftbutton_released() -> void:
	Input.action_release("move_left")


func _on_upbutton_pressed() -> void:
	Input.action_press("jump")


func _on_upbutton_released() -> void:
	Input.action_release("jump")


func _on_attackbutton_pressed() -> void:
	Input.action_press("attack")


func _on_attackbutton_released() -> void:
	Input.action_release("attack")
