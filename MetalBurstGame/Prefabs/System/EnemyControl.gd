tool
extends Node2D

class_name EnemyControl, "res://Assets/Tools/boss.png"

#avoid using soft dependencies 
#move to all the needed variables out of the instance
#and on to the script

#the default projectile this enemy shoots
#this will be pushed to the blackboard
export(PackedScene) var _defaultProjectile
export(PackedScene) var _deathSpawn


#default
export(float) var _hitSoundTimer = .2
var _hitTimerElapsed : float = _hitSoundTimer

#behavior vars
var _engineReady : bool = false#ready to roll baby
var _myEngine = null
var _brain : Brain = null

#movement vars
export(float) var _maxSpeed = 100 #max speed in pixels per second
var _speed = 0
var _velocity : Vector2 = Vector2(0,0) #velcity in the x and y directions this applies movement

#combat vars
export(float) var _maxHealth = 100 setget set_max_health
var _currentHealth : float = _maxHealth

export(float) var _fireRate = 2 setget set_fire_rate#shots per second 
var _fireElapsed: float = 0

export(float) var _despawnDistance = 600 #distance from screen center
var _screenCenter : Vector2 = Vector2(0,0)

#amount that this entity gives in score when it dies
export(int) var _deathValue = 100
#amount that this entity gives in score when it is hit
export(int) var _hitValue = 10

func _ready():
	if(Engine.is_editor_hint()):
		pass
	else:
		var _val = $EnemyArea.connect("area_entered", self, "hit")
		set_physics_process(true)
		set_process(true)
		for child in get_children():
			if(child is Brain):
				_brain = child
				break
		_speed = _maxSpeed

func _process(delta):
	_hitTimerElapsed+=delta

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

func set_max_health(maxHealth:float):
	_maxHealth = max(1,maxHealth)
	_currentHealth = _maxHealth

func set_current_health(health:float):
	_currentHealth = min(max(health,0),_maxHealth)

func get_current_health()->float: 
	return _currentHealth

func get_death_value()->int:
	return _deathValue

func get_hit_value()->int:
	return _hitValue;

#called by the engine when it adds it to the correct layer
func engine_ready(engine):
	_engineReady = true
	_myEngine = engine
	_brain.start({
		#TODO: Add ,pre variables
		BB.SELF : self,
		BB.PLAYER : Globals.get_player(),
		BB.PLAY_AREA : _myEngine.get_play_container(),
		BB.ENGINE : _myEngine,
		BB.DPROJECTILE: _defaultProjectile
	})
	_screenCenter = ZoneMap.get_zone_position(ZoneMap.Zones.Center,_myEngine.get_play_container())

func _physics_process(delta:float):
	if(!Engine.is_editor_hint() && get_engine_ready()):
		#update brain
		var _finished = _brain.update_brain(delta)
		#update movement
		position = position + ((_velocity *get_speed())* delta)
		if(self.position.distance_to(_screenCenter) >= _despawnDistance):
			#print("EnemyControl is too far from screen center -> Despawning")
			self.queue_free()
	
		

func get_engine_ready()->bool:
	return _engineReady

func get_engine():
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


func hit(object):
	#print("Enemy collision with " + object.name + " detected!")
	#player damaged
	
	if(object is ProjectileComponent):
		set_current_health(get_current_health()-object.get_damage())
		
		#example SOUND
		if _hitTimerElapsed >= _hitSoundTimer:
			var _value = Globals.audioManager.play_sound("sfx_foeHit")
			_hitTimerElapsed = 0
			
		Globals.get_player().score += get_hit_value()
		# print("Enemy[%s] took damage from Object[%s] "%[self.name,object.name])
	#HP-Threshold SFX can also be done here ; more advanced
	if get_current_health() <= 0:
		var _value = Globals.audioManager.play_sound("sfx_foeDeath")
		if _deathSpawn != null:
			var dp = _deathSpawn.instance()
			dp.position = position
			_myEngine.add_child(dp)
		Globals.get_player().score += get_death_value()
		queue_free()
	if object is Player:
		object.hit(self)

#TODO: add death animation

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
