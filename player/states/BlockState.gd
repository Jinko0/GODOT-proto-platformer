extends PlayerState
class_name BlockState

func enter():
	player.block_area_collision_shape.disabled = false
	playback.start("block_start")
	player.velocity = Vector2.ZERO
	player.block_duration.start()
	player.block_is_available = false

func exit():
	player.block_area_collision_shape.disabled = true
	player.block_cooldown.start()

func _on_block_duration_timeout():
	transitioned.emit(self, "GroundState")
