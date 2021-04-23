extends "res://Source/Actors/Actor.gd"

var can_jump:bool = true
var can_left:bool = true
var can_right:bool = true
var can_attack:bool = true
var is_attacking:bool = false
var attack_cd:bool = true
onready var current_gravity = gravity

#############################################################
#areas de respawn
#############################################################
var respawn_position = Vector2(32, 54)
export var area1 = Vector2(32, 172)
export var area2 = Vector2(432+32, 172)
export var area3 = Vector2(432*2+32, 172)
export var area4 = Vector2(432*3+32, 172)
export var area5 = Vector2(432*4+32, 172)
export var area6 = Vector2(432*5+32, 172)
export var area7 = Vector2(432*6+32, 172)
export var area8 = Vector2(432*7+32, 172)
export var area9 = Vector2(432*8+32, 172)
#############################################################

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		(Input.get_action_strength("move_right") * float(can_right))- (Input.get_action_strength("move_left") * float(can_left)), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() and can_jump else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += current_gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y=0
	return new_velocity


#############################################################
#PROCESS
#############################################################
func _process(delta: float) -> void:
	#text_update()
	play_animation()
	attack_input()
	if Input.is_action_just_pressed("jump") and can_jump:
		$sounds/sound_jump.play()


func attack_input():
	if Input.is_action_just_pressed("attack") and can_attack and attack_cd:
		is_attacking = true
		$attack_area/CollisionShape2D.disabled = false
		$sounds/sound_attack.play()
		attack_cd = false
		$attack_cd.start()

func text_update():
	if !can_jump:
		#$cantdo.push_color(Color.green)
		$cantdo.add_text("jump")
	elif !can_left:
		$cantdo.set_text("left")
	elif !can_right:
		$cantdo.set_text("right")
	elif !can_attack:
		$cantdo.set_text("attack")
	elif current_gravity<0:
		$cantdo.set_text("float")
	else:
		$cantdo.clear()
	$cantdo.push_align(RichTextLabel.ALIGN_CENTER)

#############################################################
# ANIMATION
#############################################################
func play_animation():
	if is_attacking:
		$Anima.play("attack")
	elif _velocity.x == 0:
		$Anima.play("idle")
	elif _velocity.x > 0:
		$Anima.flip_h = false
		$attack_area.set_scale(Vector2(1,1))
		$Anima.play("run")
	elif _velocity.x < 0:
		$Anima.flip_h = true
		$attack_area.set_scale(Vector2(-1,1))
		$Anima.play("run")

func _on_Anima_animation_finished() -> void:
	if $Anima.animation == "attack":
		is_attacking = false
		$attack_area/CollisionShape2D.disabled = true
	if $Anima.animation == "dead":
		set_process(true)
		set_physics_process(true)
		#$Anima.play("dead")
		set_position(set_respawn_area())#respawn

#############################################################
#AREAS
#############################################################

func _on_Area_detector_area_entered(area: Area2D) -> void:
	if area.name == "cant jump":
		can_jump = false
		$cantdo.push_color(Color.gray)
		$cantdo.add_text("jump")
	if area.name == "cant left":
		can_left = false
		$cantdo.push_color(Color.gray)
		$cantdo.add_text("left")
	if area.name == "cant right":
		$cantdo.push_color(Color.gray)
		$cantdo.add_text("right")
		can_right = false
	if area.name == "cant attack":
		$cantdo.push_color(Color.gray)
		$cantdo.add_text("attack")
		can_attack = false
	if area.name == "anti gravity":
		$cantdo.push_color(Color.greenyellow)
		$cantdo.add_text("float")
		current_gravity = (-1)*gravity

func _on_Area_detector_area_exited(area: Area2D) -> void:
	if area.name == "cant jump":
		can_jump = true
		$cantdo.clear()
	if area.name == "cant left":
		can_left = true
		$cantdo.clear()
	if area.name == "cant right":
		can_right = true
		$cantdo.clear()
	if area.name == "cant attack":
		can_attack = true
		$cantdo.clear()
	if area.name == "anti gravity":
		current_gravity = gravity
		$cantdo.clear()

#############################################################
#DYING AND RESPAWN
#############################################################

func _on_enemy_detector_body_entered(body: Node) -> void:
	die()

func die():
	set_process(false)
	set_physics_process(false)
	$Anima.play("dead")
	$sounds/sound_death.play()
	#set_position(set_respawn_position(set_respawn_area()))#respawn

func set_respawn_area():
	var area = 0
	var horizontal=0
	horizontal=int(position.x/432)
	if horizontal ==0:
		respawn_position = area1
	elif horizontal ==1:
			respawn_position = area2
	elif horizontal ==2:
		respawn_position = area3
	if horizontal ==3:
		respawn_position = area4
	elif horizontal ==4:
		respawn_position = area5
	elif horizontal ==5:
		respawn_position = area6
	if horizontal ==6:
		respawn_position = area7
	elif horizontal ==7:
		respawn_position = area8
	elif horizontal ==8:
		respawn_position = area9
	return respawn_position

func set_respawn_position(area: int):
		if area ==0:
			respawn_position = Vector2(32, 54)
		elif area ==1:
			respawn_position = Vector2(388, 181)
		elif area ==2:
			respawn_position = Vector2(810, 181)
		elif area ==3:
			respawn_position = Vector2(1095, 240)
		elif area ==4:
			respawn_position = Vector2(760, 360)
		elif area ==5:
			respawn_position = Vector2(360, 300)
		elif area ==6:
			respawn_position = Vector2(338, 473)
		elif area ==7:
			respawn_position = Vector2(403, 638)
		elif area ==8:
			respawn_position = Vector2(776, 620)
		return respawn_position


func _on_attack_cd_timeout() -> void:
	attack_cd = true
