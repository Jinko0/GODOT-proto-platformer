extends CharacterBody2D
class_name Player

const move_speed = 600.0
const jump_velocity = -800.0

@onready var sprite = $Sprite2D

var gravity = 3000.0

var double_jump_is_available : bool = true

var wall_friction : float = 500.0

var wall_pushback : float = 1500
var pushback_velocity : float
var is_pushed : bool = false

var dash_direction : float = 1
var dash_speed : float = 1500

func _physics_process(delta):
	move_and_slide()

func default_movement(input):
	if not is_pushed:
		if input.direction:
			velocity.x = input.direction * move_speed
		else:
			velocity.x = move_toward(velocity.x, 0, move_speed)
		
	apply_pushback()

func dash_movement():
	velocity.y = 0
	velocity.x = dash_direction * dash_speed

func apply_pushback():
	velocity.x += pushback_velocity
	if pushback_velocity > move_speed or pushback_velocity < -move_speed:
		is_pushed = true
		velocity.x = clampf(velocity.x, -abs(pushback_velocity), abs(pushback_velocity))
	else:
		is_pushed = false
	pushback_velocity = lerpf(pushback_velocity, 0, 0.1)
