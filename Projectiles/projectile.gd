extends Node2D
class_name Projectile

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

@export var speed : float = 200

var enemy : Enemy
var return_to_enemy = false
var target_position : Vector2
var direction := Vector2.ZERO

func _physics_process(delta):
	var velocity = direction * speed
	global_position += velocity * delta
	
	if return_to_enemy && enemy != null:
		direction = global_position.direction_to(enemy.attack_origin.global_position)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()
