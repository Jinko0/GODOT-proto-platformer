extends Area2D

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

@export var speed : float = 500

var target_position : Vector2
var direction : Vector2

func _ready():
	target_position = get_tree().get_first_node_in_group("player").global_position
	direction = global_position.direction_to(target_position)
	
func _physics_process(delta):
	position += direction * 200 * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
