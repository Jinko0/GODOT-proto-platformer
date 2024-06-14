extends Node2D

@onready var animation_player = $Area2D/AnimationPlayer

signal collected

func _ready():
	animation_player.play("idle")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.score += 1
		body.gem_sound.play()
		body.gem_picked_up.emit()
		collected.emit()
		queue_free()
