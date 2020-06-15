tool
extends Node2D

class_name EnemyControl, "res://Assets/Tools/boss.png"

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
#TODO: add take damage
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
