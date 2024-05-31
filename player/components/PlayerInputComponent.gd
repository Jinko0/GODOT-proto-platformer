extends Node
class_name PlayerInputComponent

@export var player_state : PlayerStateMachine

var direction : float
var last_direction : float = 1

func _physics_process(delta):
	direction = Input.get_axis("left", "right")
	if direction:
		last_direction = direction
	
	if Input.is_action_just_pressed("jump"):
		player_state.current_state.jump()
	
	if Input.is_action_just_pressed("dash"):
		player_state.current_state.dash()
	
	if Input.is_action_just_pressed("block"):
		player_state.current_state.block()

