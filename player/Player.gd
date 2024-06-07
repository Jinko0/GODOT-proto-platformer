extends CharacterBody2D
class_name Player

#### EXPORT

@export var move_speed = 600.0
@export var jump_velocity = -1200.0
@export var gravity = 3000.0
@export var wall_friction : float = 500.0
@export var wall_pushback : float = 2500
@export var dash_speed : float = 2000
@export var health : int = 50

#### ONREADY

@onready var sprite = $Sprite2D
@onready var sprite_attack = $SpriteAttack
@onready var dash_duration = $DashDuration
@onready var dash_cooldown = $DashCooldown
@onready var block_duration = $BlockDuration
@onready var block_cooldown = $BlockCooldown
@onready var animation_tree = $AnimationTree
@onready var player_input = $Components/PlayerInputComponent
@onready var hitbox = $HitBox
@onready var hurt_box = $HurtBox
@onready var block_area_collision_shape = $blockArea/CollisionShape2D

#### VAR

var double_jump_is_available : bool = true
var pushback_velocity : float
var is_pushed : bool = false
var dash_direction : float = 1
var dash_is_available : bool = true
var block_is_available : bool = true


func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if health <= 0:
		queue_free()
	
	for body in hurt_box.get_overlapping_bodies():
		print(body)
		
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
		update_attack_direction("left")
	elif player_input.last_direction == -1:
		sprite.flip_h = false
		update_attack_direction("right")

func update_attack_direction(direction : String):
	if direction == "left":
		sprite_attack.position.x = 80
		sprite_attack.flip_v = true
		sprite_attack.global_rotation_degrees = 115
		hitbox.scale.x = 1
	elif direction == "right":
		sprite_attack.position.x = -80
		sprite_attack.flip_v = false
		sprite_attack.global_rotation_degrees = 65
		hitbox.scale.x = -1

func update_animation():
	animation_tree.set("parameters/move/blend_position", player_input.direction.x)

func _on_dash_cooldown_timeout():
	dash_is_available = true

func _on_block_cooldown_timeout():
	block_is_available = true

func take_damage(damage: int):
	health -= damage


