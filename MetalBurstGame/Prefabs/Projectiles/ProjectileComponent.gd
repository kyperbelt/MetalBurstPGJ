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

## SFX played by this entity on initialization 
#(this is projectile initialization and not object initialization)
export(String) var _soundFX = "sfx_playerShoot"
#make sure this is a brain behavior
#if empty then this projectile will just move 
#without any intention in the initialized direction
export(PackedScene) var _behaviorScene

var _type = ProjectileType.EnemyProjectile
var _engineReady : bool = false#ready to roll baby
var _engine = null
var _screenBounds : Rect2

func _process(delta:float):
	
	if(_engineReady):
		#update brain if it exists
		if(_behaviorScene!=null):
			var _finished = _behaviorScene.update_brain(delta)
		#update movement
	
		position = position + ((_velocity.normalized() *_speed)* delta)
		if(!_screenBounds.has_point(position)):
			#not in the screen
			self.queue_free()

#set the collisionLayer for this object
func set_collision_layer(layer:int):
	collision_layer = layer

#set the collisionMask for this object
#these are the objects that this projectile
#collides with
func set_collision_mask(mask:int):
	collision_mask = mask

func engine_ready(engine):
	_engineReady = true
	_engine = engine
	var _i =connect("area_entered",self,"hit")
	set_process(true)
	if(_behaviorScene!=null):
		_behaviorScene.start({
			#TODO: Add ,pre variables
			BB.SELF : self,
			BB.PLAYER : Globals.get_player(),
			BB.PLAY_AREA : _engine.get_play_container(),
			BB.ENGINE : _engine
		})
	var container : ViewportContainer = engine.get_play_container()
	_screenBounds = Rect2(0,0,container.rect_size.x,container.rect_size.y)

func initialize(spawn_position:Vector2,initial_velocity:Vector2,type:int=1):
	if(Globals.audioManager.play_sound(_soundFX)):
		pass
	position = spawn_position
	_velocity = initial_velocity
	set_type(type)
	pass

func hit(_object):
	#some collision happened
	# we can specify unique behavior 
	# but for now we just free the bullet
	
	#TODO: insert inpact animation
	print()
	queue_free()


func get_damage()->float:
	return _damage

func get_speed()->float:
	return _speed

func set_speed(speed:float):
	_speed = speed

func get_max_speed()->float:
	return _speed

func get_class()->String:
	return "ProjectileComponent"

#projectile type 0=player 1=enemy (default=1)
func set_type(type:int=1):
	_type = type

func set_velocity(x:float,y:float):
	_velocity.x = x
	_velocity.y = y

func get_velocity()->Vector2:
	return _velocity

func is_class(object)->bool:
	return object == get_class() if object is String else object.get_class() == get_class()
