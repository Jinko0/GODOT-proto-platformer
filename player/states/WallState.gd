extends PlayerState
class_name WallState

func physics_update(delta):
	player.default_movement(player_input)
	
	if not player.is_on_floor():
		player.velocity.y += player.wall_friction * delta
	
	if not player.is_on_wall():
		transitioned.emit(self, "AirState")

func jump():
	player.velocity.y = player.jump_velocity
	
	if player.get_wall_normal() == Vector2.LEFT:
		player.pushback_velocity = -player.wall_pushback
	elif player.get_wall_normal() == Vector2.RIGHT:
		player.pushback_velocity = player.wall_pushback

func dash():
	## lors d'un dash depuis un mur on veux dash dans la direction opposée
	player_input.last_direction = -player_input.last_direction
	transitioned.emit(self,"DashState")

