extends Control

@onready var world = get_parent().get_parent()
@onready var reprendre = $MarginContainer/VBoxContainer/Reprendre

func _on_reprendre_pressed():
	world.freeze_game()

func _on_quitter_pressed():
	world.freeze_game()
	get_tree().change_scene_to_file("res://menu/menu.tscn")
