extends Enemy
class_name GroundEnemy

@onready var right_limit = $Right_limit
@onready var left_limit = $Left_limit
@onready var player_detection = $PlayerDetection

@onready var sprite = $Sprite2D
@onready var animation_tree = $AnimationTree

@export var speed : float = 200

var playback : AnimationNodeStateMachinePlayback

var direction = 1

func enemy_is_ready():
	animation_tree.active = true
	playback = animation_tree["parameters/playback"]

func _process(delta):
	animation_tree.set("parameters/move/blend_position", direction)

	check_if_enemy_is_dead()

func _physics_process(delta):
	move_and_slide()
