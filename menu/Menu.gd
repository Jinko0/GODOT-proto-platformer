extends Control

func _on_jouer_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")

func _on_quitter_pressed():
	get_tree().quit()
