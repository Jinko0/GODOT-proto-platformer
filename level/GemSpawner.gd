extends Node

var gem = preload("res://level/Gem.tscn")

var spawn_points : Array = []
var last_spawn = Marker2D

func _ready():
	for child in get_children():
		if child.is_in_group("spawn_point"):
			spawn_points.append(child)
	
	var rnd_spawn = get_rnd_spawn(spawn_points)
	last_spawn = rnd_spawn
	spawn_points.erase(rnd_spawn)
	
	new_gem(rnd_spawn)


func gem_collected():
	var rnd_spawn = get_rnd_spawn(spawn_points)
	spawn_points.append(last_spawn)
	last_spawn = rnd_spawn
	spawn_points.erase(rnd_spawn)
	
	new_gem(rnd_spawn)

func get_rnd_spawn(spawn_points : Array) -> Marker2D :
	var rnd_index = randi() % spawn_points.size()
	var rnd_spawn = spawn_points[rnd_index]
	return rnd_spawn

func new_gem(rnd_spawn : Marker2D):
	var gem_instance = gem.instantiate()
	gem_instance.connect("collected", gem_collected)
	gem_instance.global_position = rnd_spawn.global_position
	call_deferred("add_child", gem_instance)




