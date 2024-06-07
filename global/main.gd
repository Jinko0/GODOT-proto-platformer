extends Node2D

@onready var projectile_manager = $ProjectileManager

func _ready():
	GlobalSignals.projectile_fired.connect(projectile_manager.handle_projectile_spawned)

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
