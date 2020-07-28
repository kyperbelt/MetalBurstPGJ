extends Area2D

# this will eventually move to be our base projectile class
class_name ProjectileComponent, "res://Assets/Tools/projectile.png"

enum ProjectileType{
	PlayerProjectile,
	EnemyProjectile
}

#this damage is only relavant when the player is firing the projectile
export(float) var _damage = 10
export(float) var _speed = 100
export(String) var _soundFX = "sfx_playerShoot"

var type=ProjectileType.EnemyProjectile

func get_damage()->float:
	return _damage

func get_class()->String:
	return "ProjectileComponent"

func is_class(object)->bool:
	return object == get_class() if object is String else object.get_class() == get_class()
