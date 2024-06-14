extends PlayerState
class_name AttackState

var current_attack : String
var next_attack : int
var max_attack : int = 3

@export var attack_sound : AudioStreamPlayer

func update(_delta: float):
	if current_attack == "attack_" + str(next_attack):
		playback.travel("attack_" + str(next_attack))
		if next_attack < max_attack:
			next_attack += 1
	

	if !playback.get_current_node().contains("attack"):
		transitioned.emit(self, "GroundState")

func enter():
	current_attack = "attack_1"
	next_attack = 2
	player.velocity = Vector2.ZERO
	playback.start("attack_1")


func attack():
	if current_attack == playback.get_current_node():
		attack_sound.play()
		current_attack = "attack_" + str(next_attack)

func stop_attack():
	current_attack = ""
	playback.travel("move")

func block():
	if player.block_is_available:
		transitioned.emit(self,"BlockState")
