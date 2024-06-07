extends Enemy
class_name AirEnemy

@onready var player_detection = $PlayerDetection
@onready var animation_tree = $AnimationTree
@onready var attack_origin = $AttackOrigin
@onready var hurt_box = $HurtBox

var playback : AnimationNodeStateMachinePlayback
var tween : Tween

var max_y_offset := -40

func _process(delta):
	if health <= 0:
		queue_free()

func _ready():
	animation_tree.active = true
	playback = animation_tree["parameters/playback"]
	
	tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops()
	tween.tween_property(self, "position", Vector2(position.x, position.y + max_y_offset), 2)
	tween.tween_property(self, "position", Vector2(position.x, position.y - max_y_offset), 2)
