extends EnemyState
class_name GroundEnemyAttackState

func enter():
	enemy.velocity.x = 0
	enemy.playback.start("attack")

func switch_state_after_attack():
	transitioned.emit(self, "EnemyRollState")
