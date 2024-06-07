extends Enemy
class_name GroundEnemy

@onready var right_limit = $Right_limit
@onready var left_limit = $Left_limit
@onready var player_detection = $PlayerDetection

@onready var sprite = $Sprite2D
@onready var animation_tree = $AnimationTree

@export var speed : float = 200

var direction = 1
var playback : AnimationNodeStateMachinePlayback

func _ready():
	animation_tree.active = true
	playback = animation_tree["parameters/playback"]

func _process(delta):
	animation_tree.set("parameters/move/blend_position", direction)

	if health <= 0:
		queue_free()


func _physics_process(delta):
	move_and_slide()
