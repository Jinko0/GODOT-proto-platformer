extends PlayerState
class_name IdleState

func physics_update(delta):
	player.default_movement(player_input)

	if not player.is_on_floor():
		transitioned.emit(self, "AirState")

func enter():
	player.double_jump_is_available = true

func jump():
	player.velocity.y = player.jump_velocity

func dash():
	transitioned.emit(self,"DashState")

