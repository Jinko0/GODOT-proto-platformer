extends CharacterBody2D
class_name Enemy

@export var health := 30
@export var state_machine : EnemyStateMachine

var life_fragment = preload("res://enemies/scenes/life_fragment.tscn")
var spawn_effect = preload("res://particles/spawn.tscn")
var hit_effect = preload("res://particles/explosion1.tscn")

signal spawn_free

var spawn : Marker2D


func _ready():
	var spawn_effect_instance = spawn_effect.instantiate()
	spawn_effect_instance.global_position = Vector2.ZERO
	add_child(spawn_effect_instance)
	spawn_effect_instance.emitting = true
	
	enemy_is_ready()

func take_damage(damage : int):
	var hit_effect_instance = hit_effect.instantiate()
	hit_effect_instance.global_position = global_position
	get_tree().get_first_node_in_group("effect_manager").add_child(hit_effect_instance)
	hit_effect_instance.emitting = true
	health -= damage
	state_machine.current_state.transitioned.emit(state_machine.current_state, "EnemyHurtState")

static func new_enemy(enemy_type, spawn) -> Enemy:
	var new_enemy: Enemy = enemy_type.instantiate()
	new_enemy.global_position = spawn.global_position
	new_enemy.spawn = spawn
	return new_enemy

func check_if_enemy_is_dead():
		if health <= 0:
			
			if (randi() % 100 + 1) > 85:
				var life_fragement_instance = life_fragment.instantiate()
				life_fragement_instance.global_position = global_position
				get_tree().get_first_node_in_group("effect_manager").add_child(life_fragement_instance)
			spawn_free.emit(spawn)
			queue_free()

func enemy_is_ready():
	pass
