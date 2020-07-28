extends Area2D

# this will eventually move to be our base projectile class
class_name ProjectileComponent, "res://Assets/Tools/projectile.png"

enum ProjectileType{
	PlayerProjectile,
	EnemyProjectile
}

#this damage is only relavant when the player is firing the projectile
export(float) var _damage = 10

## MOVEMENT 
export(float) var _speed = 100
var _velocity : Vector2 = Vector2(0,0) #velcity in the x and y directions this applies movement

## SFX played by this entity on init
export(String) var _soundFX = "sfx_playerShoot"

var _type = ProjectileType.EnemyProjectile

func init(spawn_position:Vector2):
	if(Globals.audioManager.play_sound(_soundFX)):
		pass
		
	pass


func get_damage()->float:
	return _damage

func get_class()->String:
	return "ProjectileComponent"

#projectile type 0=player 1=enemy (default=1)
func set_type(type:int=1):
	_type = type

func set_velocity(x:float,y:float):
	_velocity.x = x
	_velocity.y = y

func is_class(object)->bool:
	return object == get_class() if object is String else object.get_class() == get_class()
