extends "res://Source/Actors/Actor.gd"
class_name Enemy_Class

#export timer -> andar pra direita/parar/andar pra esquerda
#2 timers: timer1 = x; timer2 = x+y, sendo x o tempo andando e y o tempo parado
#timer2 ativa andar(); timer1 ativa parar e chama mudanca de direcao
export var initial_direction: float = 1.0#se 1, ele comeca para a direita, se -1 ele comeca para a esquerda
export var tempo_andando = 1.4
export var tempo_parado = 0.7
var direction = Vector2(1.0,0.0)#se 1, ele comeca para a direita, se -1 ele comeca para a esquerda
var velocity = Vector2(0,0)

func _ready() -> void:
	set_physics_process(false)
	#$timer1.wait_time = tempo_andando
	#$timer2.wait_time = tempo_parado
	#direction.x = initial_direction

func _physics_process(delta: float) -> void:
	velocity.x = speed.x
	velocity.x *= direction.x
	velocity.y += gravity * get_physics_process_delta_time()
	move_and_slide(velocity, FLOOR_NORMAL)

func _start():
	$timer1.wait_time = tempo_andando
	$timer2.wait_time = tempo_parado
	direction.x = initial_direction
#############################################################
#PROCESS
#############################################################
func _process(delta: float) -> void:
	play_animation()

func play_animation():
	if velocity.x == 0:
		$Anima.play("idle")
	elif velocity.x > 0:
		$Anima.flip_h = false
		$Anima.play("walk")
	elif velocity.x < 0:
		$Anima.flip_h = true
		$Anima.play("walk")
#############################################################
#TIMER
#############################################################
func _on_timer1_timeout() -> void:
	direction.x = 0.0
	$timer2.start()

func _on_timer2_timeout() -> void:
	initial_direction *= -1
	direction.x = initial_direction
	$timer1.start()


#############################################################
#DYING
#############################################################

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "attack_area":
		disable_body()
		die()

func die():
	disable_processes()
	$Anima.play("dead")
	get_node("sounds/sound_get_hit").play()

func disable_body():
	get_node("enemy_body").call_deferred("set_disabled", true)

func disable_processes():
	set_process(false)
	set_physics_process(false)

func _on_VisibilityEnabler2D_screen_entered() -> void:
	set_physics_process(true)
	_start()


func _on_Anima_animation_finished() -> void:
	if $Anima.animation == "dead":
		queue_free()
