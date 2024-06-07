extends Area2D
class_name HurtBox

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox == null or not hitbox is HitBox:
		return
		
	if not owner.is_in_group("AirEnemy"):
		take_damage(hitbox.damage)
		destroy_projectile(hitbox)
	elif owner.is_in_group("AirEnemy") && hitbox.is_in_group("projectile"):
		if hitbox.get_parent().return_to_enemy:
			take_damage(hitbox.damage)
			destroy_projectile(hitbox)

func take_damage(damage: int):
	if owner.has_method("take_damage"):
		owner.take_damage(damage)

func destroy_projectile(hitbox: Area2D):
	if hitbox.is_in_group("projectile"):
		hitbox.get_parent().queue_free()

