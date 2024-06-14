extends Node
class_name PlayerInputComponent

@export var player_state : PlayerStateMachine

var direction : Vector2
var last_direction : float = 1

func _physics_process(delta):
	direction.x = Input.get_axis("left", "right")
	direction = direction.round()
	if direction.x:
		last_direction = direction.x
	
	if Input.is_action_just_pressed("jump"):
		player_state.current_state.jump()
	
	if Input.is_action_just_pressed("dash"):
		player_state.current_state.dash()
	
	if Input.is_action_just_pressed("block"):
		player_state.current_state.block()
		
	if Input.is_action_pressed("attack"):
		player_state.current_state.attack()
	
	if Input.is_action_just_released("attack"):
		player_state.current_state.stop_attack()


