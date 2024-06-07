extends CharacterBody2D
class_name Enemy

@export var health := 30

func take_damage(damage : int):
	health -= damage

