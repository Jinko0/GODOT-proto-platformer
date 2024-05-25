extends PlayerState
class_name DashState

@onready var dash_timer = $DashTimer

func physics_update(delta):
	player.dash_movement()

func enter():
	player.dash_direction = player_input.last_direction
	
	dash_timer.start()

func _on_dash_timer_timeout():
	if player.is_on_floor():
		transitioned.emit(self, "GroundState")
	else:
		transitioned.emit(self, "AirState")
