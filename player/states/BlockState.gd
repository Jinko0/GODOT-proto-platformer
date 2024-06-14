extends PlayerState
class_name BlockState

@export var block_sound : AudioStreamPlayer

var shield_particle = preload("res://particles/parade3.tscn")
var shield_particle_instance : Node2D

func enter():
	block_sound.play()
	shield_particle_instance = shield_particle.instantiate()
	shield_particle_instance.global_position = player.global_position
	add_child(shield_particle_instance)
	player.block_area_collision_shape.disabled = false
	playback.start("block_start")
	player.velocity = Vector2.ZERO
	player.block_duration.start()
	player.block_is_available = false

func exit():
	shield_particle_instance.queue_free()
	player.block_area_collision_shape.disabled = true
	player.block_cooldown.start()

func _on_block_duration_timeout():
	transitioned.emit(self, "GroundState")
