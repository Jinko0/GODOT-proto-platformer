extends EnemyState
class_name EnemyAirState

func physics_update(delta: float):
	for body in enemy.player_detection.get_overlapping_bodies():
		if body.name == "Player":
			transitioned.emit(self, "AirEnemyAttackState")
