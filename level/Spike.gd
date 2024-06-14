extends Area2D

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area : Area2D):
	print("area entered")
	if area.get_parent().is_in_group("player"):
		print("test")
