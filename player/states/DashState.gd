extends PlayerState
class_name DashState

func physics_update(delta):
	player.dash_movement()

func enter():
	playback.start("dash")
	
	player.dash_direction = player_input.last_direction
	
	player.dash_duration.start()
	player.dash_is_available = false

func exit():
	player.dash_cooldown.start()

func _on_dash_timer_timeout():
	if player.is_on_floor():
		transitioned.emit(self, "GroundState")
	else:
		transitioned.emit(self, "AirState")


