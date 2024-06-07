extends EnemyState
class_name AirEnemyAttackState

var projectile = preload("res://Projectiles/projectile.tscn")

var player : Player

func enter():
	enemy.playback.start("attack_start")
	player = get_tree().get_first_node_in_group("player")

func exit():
	enemy.playback.start("attack_end")
	player = null

func _on_shoot_timer_timeout():
	if player != null:
		var projectile_instance = projectile.instantiate()
		projectile_instance.enemy = enemy
		var direction = enemy.attack_origin.global_position.direction_to(player.global_position)
		GlobalSignals.emit_signal("projectile_fired", projectile_instance, enemy.attack_origin.global_position, direction)

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		transitioned.emit(self, "EnemyAirState")

