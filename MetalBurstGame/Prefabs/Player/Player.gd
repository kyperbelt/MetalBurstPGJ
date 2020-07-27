extends Node2D

class_name Player

export(PackedScene) var BULLET_PROJECTILE 

enum PROJECTILES {
	PLAYER_BULLET,
	PLAYER_BOMB = 2
	
}

const RELOAD_TIME = 0.125 

# player invinvibility frames duration
export(float) var _invinvibilityAmount = 2.5;
var _invinvibilityTimer : float = 0;#the timer is set to the duration above. whilst in this state we are invulnerable/invincible

#speed management variables 
export(float) var _speed : float = 300  #normal speed of play
export(float) var _focusSpeed : = 50 	#speed refuced from focus
var _speedMultiplier:float = 1.0 		#speed multiplier - can be used to add speed boosts within the game
var _currentSpeed = _speed 				#the current speed of the player (will be swaped out in code with _speed and _focusSpeed dpending on state)

var play_area_width : int = 640
var play_area_height : int = 540
var bullet_reloading = 0.0
var bomb_reloading = 0.1
var pos
var direction
var parent
var shot_timer = 0
var bomb_timer = 0
var cooldown = 0.2
var bomb_cooldown = 0.2
var firing = false
var bombing = false

var invulnerable : bool = false

signal player_hit
signal score_changed

#######################
var score: int = 0 setget _set_score
var lives: int = 4
#percentage of energy for bomb 0 - 1
var bomb_percentage:float=1.0
#the cost of the bomb in energy percentage
export(float,.01,1.0) var bomb_cost:float=.25 
export(float) var _rechargeRate = .1

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	set_process(true)


func _process(delta):

	#invinvibility frames countdown
	_invinvibilityTimer -= delta
	_animate_invincibility()

	# shot_timer -= delta
	shot_timer = -1
	bomb_timer -= delta
	if Input.is_action_pressed("fire"):
		if shot_timer <= 0:
			shoot()
			firing = true
		else:
			firing = false
	if Input.is_action_pressed("player_bomb"):
		if bomb_timer <= 0:
			bomb_away()
			bombing = true
		else:
			bombing = false

	########################################
	# 				MOVEMENT 
	var move : Vector2 = Vector2(0,0);#temporary vector used to store movement data for this frame
	#input handling
	if Input.is_action_pressed("move_up"):
		move.y-=_currentSpeed *_speedMultiplier
	if Input.is_action_pressed("move_down"):
		move.y+=_currentSpeed *_speedMultiplier 
	if Input.is_action_pressed("move_left"):
		move.x-=_currentSpeed *_speedMultiplier
	if Input.is_action_pressed("move_right"):
		move.x+=_currentSpeed *_speedMultiplier
	if Input.is_action_pressed("move_slower"):
		_currentSpeed = _focusSpeed;
		#TODO: Insert Animation trigger for focus mode
	else:
		_currentSpeed = _speed
	#apply move vector translation	
	translate(move*delta)

	#clamping code - keeps player withing the bounds of the play area
	if(position.x < 0) : position.x = 0
	if(position.x > play_area_width) : position.x = play_area_width
	if(position.y < 0) : position.y = 0;
	if(position.y > play_area_height): position.y = play_area_height

	#########################################
	bullet_reloading -= delta
	bomb_reloading -= delta

	bomb_percentage = min(bomb_percentage+_rechargeRate*delta,1)



#collision has started with something
func on_collision_start(area):
	#print_tree_pretty()
	var node = area.get_parent()
	print("collision with "+node.name+" detected!")


func hit(object):
	if ( _invinvibilityTimer >= 0) :return 
	print("player is hit by =%s" % object.name)
	lives-=1
	var _value = Globals.audioManager.play_sound("sfx_playerHit")
	emit_signal("player_hit")
	_invinvibilityTimer=_invinvibilityAmount;

func _set_score(_score:int)->void:
	score =_score
	emit_signal("score_changed")

#use modulate to animate invincibility
func _animate_invincibility():
	if ( _invinvibilityTimer >= 0) :# invinsibility
		var delta:float = 1-(_invinvibilityTimer/_invinvibilityAmount);
		var freq:float = 30;
		modulate = Color(1,0,0,.35*cos(freq*delta)+.65);
	else : #no invinsibility
		modulate = Color(1,1,1,1);



func start(_pos):
	position = _pos
	$Collisionshape2D.disabled = false

func shoot():
	if bullet_reloading <= 0.0:
		var bullet = BULLET_PROJECTILE.instance()
		bullet.setProjectileType(PROJECTILES.PLAYER_BULLET)
		bullet.global_position = global_position
		var _value = Globals.audioManager.play_sound("sfx_playerShoot")
		#bullet.change_speed(_speed)
		if(!is_instance_valid(parent)):
			parent = get_parent()
		parent.add_child(bullet)
		shot_timer = cooldown
		bullet_reloading = RELOAD_TIME

func bomb_away():
	if bomb_reloading <= 0.0 && bomb_percentage>=bomb_cost:
		bomb_percentage-=bomb_cost
		var bomb = BULLET_PROJECTILE.instance()
		bomb.setProjectileType(PROJECTILES.PLAYER_BOMB)
		bomb.global_position = global_position
		var _value = Globals.audioManager.play_sound("sfx_playerBomb")
		#bullet.change_speed(_speed)
		if(!is_instance_valid(parent)):
			parent = get_parent()
		parent.add_child(bomb)
		bomb_timer = bomb_cooldown
		bomb_reloading = RELOAD_TIME

		
