extends EnemyState

func enter():
	enemy.velocity.x = 0
	enemy.playback.start("hurt")
	
func switch_state_after_take_hit(state : String):
	transitioned.emit(self, state)
