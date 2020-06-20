extends Area2D

# this will eventually move to be our base projectile class
class_name ProjectileComponent

export(float) var _damage = 10

func get_damage()->float:
	return _damage

func get_class()->String:
	return "ProjectileComponent"

func is_class(object)->bool:
	return object == get_class() if object is String else object.get_class() == get_class()
