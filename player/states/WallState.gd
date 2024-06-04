extends PlayerState
class_name WallState

func physics_update(delta):
	player.default_movement(player_input)
	
	if not player.is_on_floor():
		player.velocity.y += player.wall_friction * delta
	else:
		transitioned.emit(self, "GroundState")
	
	if not player.is_on_wall():
		transitioned.emit(self, "AirState")

func enter():
	### pour compenser le décalage sur la spritesheet ###
	if player_input.last_direction == 1:
		player.sprite.position.x += 20
	elif player_input.last_direction == -1:
		player.sprite.position.x -= 20
	######
	
	playback.start("wall_slide")

func exit():
	### pour compenser le décalage sur la spritesheet ###
	player.sprite.position.x = 0
	######
	
func jump():
	playback.travel("jump_start")
	player.velocity.y = player.jump_velocity
	
	if player.get_wall_normal() == Vector2.LEFT:
		player.pushback_velocity = -player.wall_pushback
	elif player.get_wall_normal() == Vector2.RIGHT:
		player.pushback_velocity = player.wall_pushback

func dash():
	if player.dash_is_available:
		## lors d'un dash depuis un mur on veux dash dans la direction opposée
		player_input.last_direction = -player_input.last_direction
		player.sprite.flip_h = !player.sprite.flip_h
		transitioned.emit(self,"DashState")
