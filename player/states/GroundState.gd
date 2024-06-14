extends PlayerState
class_name IdleState

func physics_update(delta):
	player.default_movement(player_input)

	if not player.is_on_floor():
		transitioned.emit(self, "AirState")

func enter():
	playback.travel("Start")
	player.double_jump_is_available = true


func jump():
	player.emit_particle_effect(player.jump_effect, player.global_position - Vector2(0, -70), get_tree().get_first_node_in_group("effect_manager"), true)
	playback.travel("jump_start")
	player.velocity.y = player.jump_velocity

func dash():
	if player.dash_is_available:
		transitioned.emit(self,"DashState")

func block():
	if player.block_is_available:
		transitioned.emit(self,"BlockState")

func attack():
	transitioned.emit(self, "AttackState")

