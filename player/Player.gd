extends CharacterBody2D
class_name Player

#### EXPORT

@export var move_speed = 800.0
@export var acceleration = 0.2
@export var friction = 0.3
@export var jump_velocity = -1500.0
@export var gravity = 3000.0
@export var wall_friction : float = 500.0
@export var wall_pushback : float = 2500
@export var dash_speed : float = 2000
@export var max_health : int = 50

#### ONREADY

@onready var sprite = $Sprite2D
@onready var sprite_attack = $SpriteAttack
@onready var dash_duration = $DashDuration
@onready var dash_cooldown = $DashCooldown
@onready var block_duration = $BlockDuration
@onready var block_cooldown = $BlockCooldown
@onready var invincible_timer = $InvincibleTimer
@onready var camera = $Camera2D
@onready var animation_tree = $AnimationTree
@onready var player_input = $Components/PlayerInputComponent
@onready var hitbox = $HitBox
@onready var hurt_box = $HurtBox
@onready var block_area_collision_shape = $blockArea/CollisionShape2D
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var player_state_machine = $PlayerStateMachine
@onready var gem_sound = $gem_sound
@onready var hurt_sound = $hurt_sound

#### SIGNAL

signal gem_picked_up

#### VAR

var blood_effect = preload("res://particles/bloodsplash.tscn")
var jump_effect = preload("res://particles/smokejump.tscn")
var slide_effect = preload("res://particles/slidesmoke.tscn")

var double_jump_is_available : bool = true
var pushback_velocity : float
var is_pushed : bool = false
var dash_direction : float = 1
var dash_is_available : bool = true
var block_is_available : bool = true
var invincible = false
var health : int
var score : int
var mat : ShaderMaterial
var camera_zoomed = true
var slide_effect_instance : GPUParticles2D


func _ready():
	health = max_health
	animation_tree.active = true
	mat = sprite.material as ShaderMaterial
	mat.set_shader_parameter("hit_opacity", 0)
	
	slide_effect_instance = emit_particle_effect(slide_effect, Vector2.ZERO, self, false)


func _process(delta):
	progress_bar.value = health
	if invincible:
		if Engine.get_frames_drawn() % 2 == 0:
			mat.set_shader_parameter("hit_opacity", 0)
		else:
			mat.set_shader_parameter("hit_opacity", 1)

func _physics_process(delta):
	if health <= 0:
		get_tree().change_scene_to_file("res://menu/menu.tscn")
	
	move_and_slide()
	update_animation()

func default_movement(input):
	if not is_pushed:
		if input.direction.x:
			velocity.x = lerp(velocity.x, input.direction.x * move_speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0.0, friction)
			
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
	pushback_velocity = lerpf(pushback_velocity, 0, 0.2)

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
	if invincible:
		return
	
	hurt_sound.play()
	camera.apply_shake()
	emit_particle_effect(blood_effect, Vector2.ZERO, self, true)
	health -= damage
	invincible = true
	invincible_timer.start()

func _on_invincible_timer_timeout():
	mat.set_shader_parameter("hit_opacity", 0)
	invincible = false

func _input(event):
	if event.is_action_pressed("camera"):
		if camera_zoomed:
			camera.set_zoom(Vector2(0.2, 0.2))
			camera_zoomed = false
		else:
			camera.set_zoom(Vector2(0.7, 0.7))
			camera_zoomed = true

func emit_particle_effect(particle_scene, spawn_position, parent, emitting):
	var instance = particle_scene.instantiate()
	instance.global_position = spawn_position
	parent.add_child(instance)
	instance.emitting = emitting
	return instance
