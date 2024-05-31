extends PlayerState
class_name AirState

func physics_update(delta):
	
	player.default_movement(player_input)
	
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	
	if player.velocity.y > 0:
		playback.travel("fall")
		
		if slides_on_a_wall():
			transitioned.emit(self, "WallState")

	if player.is_on_floor():
		transitioned.emit(self, "GroundState")

func slides_on_a_wall():
		if (player.is_on_wall() 
		and (Input.is_action_pressed("left") or Input.is_action_pressed("right"))):
			return true

func exit():
	player.pushback_velocity = 0

func jump():
	if player.double_jump_is_available:
		playback.start("jump_start")
		player.velocity.y = player.jump_velocity
		player.double_jump_is_available = false

func dash():
	if player.dash_is_available:
		transitioned.emit(self,"DashState")
