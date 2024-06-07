extends Area2D

@export var returned_projectile_speed = 400

func _on_area_entered(area):
	if area.is_in_group("projectile"):
		var projectile = area.get_parent()
		projectile.set_direction(-projectile.direction)
		projectile.speed = returned_projectile_speed
		projectile.return_to_enemy = true
