extends CharacterBody2D

var projectile = preload("res://Projectiles/projectile.tscn")



func _on_shoot_timer_timeout():
	var projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	pass # Replace with function body.
