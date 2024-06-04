extends CharacterBody2D
class_name Player

@export var move_speed = 600.0
@export var jump_velocity = -1200.0

@onready var sprite = $Sprite2D

@export var gravity = 3000.0

var double_jump_is_available : bool = true

@export var wall_friction : float = 500.0

@export var wall_pushback : float = 2500
var pushback_velocity : float
var is_pushed : bool = false

var dash_direction : float = 1
@export var dash_speed : float = 2000

@onready var dash_duration = $DashDuration
@onready var dash_cooldown = $DashCooldown
var dash_is_available : bool = true

@onready var block_duration = $BlockDuration
@onready var block_cooldown = $BlockCooldown
var block_is_available : bool = true



@onready var animation_tree = $AnimationTree
@onready var player_input = $Components/PlayerInputComponent



func _ready():
	animation_tree.active = true

func _physics_process(delta):
	print(player_input.direction.x)
	move_and_slide()

	update_animation()

func default_movement(input):
	if not is_pushed:
		if input.direction.x:
			velocity.x = input.direction.x * move_speed
		else:
			velocity.x = move_toward(velocity.x, 0, move_speed)
			
	update_direction()
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

func update_direction():
	if player_input.last_direction == 1:
		sprite.flip_h = true
	elif player_input.last_direction == -1:
		sprite.flip_h = false

func update_animation():
	animation_tree.set("parameters/move/blend_position", player_input.direction.x)

func _on_dash_cooldown_timeout():
	dash_is_available = true

func _on_block_cooldown_timeout():
	block_is_available = true
