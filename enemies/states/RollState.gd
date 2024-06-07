extends EnemyState
class_name EnemyRollState

func physics_update(delta):
	if not enemy.right_limit.is_colliding() or not enemy.left_limit.is_colliding() or enemy.is_on_wall():
		enemy.direction = -enemy.direction
		
	enemy.velocity.y += 10
	enemy.velocity.x = enemy.direction*enemy.speed
	
	if enemy.player_detection.is_colliding():
		transitioned.emit(self, "GroundEnemyAttackState")

