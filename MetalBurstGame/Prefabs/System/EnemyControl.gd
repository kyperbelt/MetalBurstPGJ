tool
extends Node2D

class_name EnemyControl, "res://Assets/Tools/boss.png"

#avoid using soft dependencies 
#move to all the needed variables out of the instance
#and on to the script
export(PackedScene) var BULLET_TEST 

#behavior vars
var _engineReady : bool = false#ready to roll baby
var _myEngine : MBengine = null
var _brain : Brain = null

#movement vars
export(float) var _maxSpeed = 100 #max speed in pixels per second
var _speed = 0
var _velocity : Vector2 = Vector2(0,0) #velcity in the x and y directions this applies movement

#combat vars
export(float) var _maxHealth = 100 #TODO: make setget to prevent negatives
var _currentHealth : float = _maxHealth

export(float) var _fireRate = 2 setget set_fire_rate#shots per second 
var _fire_elapsed


func _ready():
	if(Engine.is_editor_hint()):
		pass
	else:
		var _val = $EnemyArea.connect("area_entered", self, "hit")
		set_physics_process(true)
		for child in get_children():
			if(child is Brain):
				_brain = child
				break
		_speed = _maxSpeed

func set_velocity(x:float,y:float):
	_velocity.x = x
	_velocity.y = y

func get_velocity()->Vector2:
	return _velocity

func get_position():
	return position

func get_max_speed()->float:
	return _maxSpeed

func set_speed(speed:float):
	_speed = min(get_max_speed(),max(speed,0))

func get_speed()->float:
	return _speed

func set_current_health(health:float):
	_currentHealth = min(max(health,0),_maxHealth)

func get_current_health()->float: 
	return _currentHealth

#called by the engine when it adds it to the correct layer
func engine_ready(engine):
	_engineReady = true
	_myEngine = engine
	_brain.start({
		#TODO: Add ,pre variables
		BB.SELF : self,
		BB.PLAYER : Globals.get_player(),
		BB.PLAY_AREA : _myEngine.get_play_container()
	})

func _physics_process(delta:float):
	if(!Engine.is_editor_hint()):
		#update brain
		var _finished = _brain.update_brain(delta)
		#update movement
		position = position + ((_velocity *get_speed())* delta)
		

func get_engine_ready()->bool:
	return _engineReady

func get_engine()->MBengine:
	return _myEngine


##########################################################
#@@@@@@@@@@@@@@@@@@ EXPORT SETGETS @@@@@@@@@@@@@@@@@@@@@@#
##########################################################

func get_fire_rate()->float:
	return _fireRate

func set_fire_rate(fireRate:float):
	_fireRate = max(0,fireRate)

##########################################################
#@@@@@@@@@@@@@@@@@@@@ Deprecated @@@@@@@@@@@@@@@@@@@@@@@@#
##########################################################
#TODO: add shoot
func shoot():
	#attempt to shoot if already placed in correct engine layer
	#otherwise return and do nothing
	if(!_engineReady):
		return
	var bullet = BULLET_TEST.instance()#stop using this-use class
	bullet.setProjectileType(1)# 1 = ENEMY_BULLET
	bullet.position = position
	#bullet.change_speed(speed)
	_myEngine.add_child(bullet)
	print("shoot")

#TODO: add take damage
func hit(object):
	print("Enemy collision with " + object.name + " detected!")
	#player damaged
	
	if(object is ProjectileComponent):
		set_current_health(get_current_health()-object.get_damage())
		print("Enemy[%s] took damage from Object[%s] "%[self.name,object.name])
	#HP-Threshold SFX can also be done here ; more advanced
	if get_current_health() <= 0:
		#$FoeDeathSFX.play()
		print(self.name + "has died!")
		queue_free()
	if object.name == 'PlayerCollisionArea':
		#TODO: we should move this method out of here-
		# right now the enemy is basically handling player collision with itself
		# which should not be the case. 
		object.get_parent().hit(self)
		queue_free()

#TODO: add death

##########################################################
#@@@@@@@@@@@@@@@@@@@@@@@@ EDITOR @@@@@@@@@@@@@@@@@@@@@@@@#
##########################################################

func _get_configuration_warning():
	if(Engine.is_editor_hint()):
		for child in get_children():
			if(child is Brain):
				return ""
		return """This Enemy does not have a Brain - Therefore It will not be able to proccess behaviors.
				Try adding a brain node -> and then add behaviors to that brain"""
	else:
		return ""

func is_class(type):
	return type == get_class()

func get_class():
	return "Enemy"
