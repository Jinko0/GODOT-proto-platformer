extends Node
class_name EnemySpawner

var enemy : PackedScene

@onready var spawn_timer = $Spawn_timer

var spawn_points : Dictionary = {}


func _ready():
	
	set_enemy_scene_type()
	
	for child in get_children():
		if child.is_in_group("spawn_point"):
			spawn_points[child.name] = child


func _on_spawn_timer_timeout():
	for spawn in spawn_points:
		if spawn_points[spawn] != null:
			var enemy_instance = Enemy.new_enemy(enemy, spawn_points[spawn])
			enemy_instance.connect("spawn_free", free_spawn)
			add_child(enemy_instance)
			spawn_points[spawn] = null


func free_spawn(spawn_to_free):
	for spawn in spawn_points:
		if spawn == spawn_to_free.name:
			spawn_points[spawn] = spawn_to_free


# Child overwrite this for determine enemy type
func set_enemy_scene_type():
	pass
