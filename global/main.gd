extends Node2D
class_name World

@onready var projectile_manager = $ProjectileManager
@onready var pause_menu = $CanvasLayer/PauseMenu

var level = preload("res://level/level_1.tscn")

var paused = false

func _ready():
	var level_instance = level.instantiate()
	add_child(level_instance)
	pause_menu.hide()
	GlobalSignals.projectile_fired.connect(projectile_manager.handle_projectile_spawned)

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

	if event.is_action_pressed("pause"):
		freeze_game()

func freeze_game():
	pause_menu.reprendre.grab_focus()
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
