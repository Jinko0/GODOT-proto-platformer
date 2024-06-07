extends Node2D
class_name ProjectileManager

func handle_projectile_spawned(projectile: Projectile, position: Vector2, direction: Vector2):
	add_child(projectile)
	projectile.global_position = position
	projectile.set_direction(direction)
