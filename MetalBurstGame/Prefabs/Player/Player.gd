extends Node2D

class_name Player

export(PackedScene) var BULLET_PROJECTILE 

enum PROJECTILES {
	PLAYER_BULLET,
	PLAYER_BOMB = 2
	
}

#MULTIPLIER
# can be set individually for each player type or left at default values
export(float) var _multiplierDeadZone 		= 4.0 #deadzone meaning :the time of inactivity it takes to lose multiplier
export(float) var _scoreExpIncrementRate 	= 200 #the increment at which to up the multiploer (increases exponentially at a rate of 2 to the power of)
export(int) var _scoreMultiplierGrowth   	= 2   # The growth of the multiplier past stage 2(example: stage3=x4 stage4=x8 stage 5=x16)
export(int) var _deadZoneMultDropLimit		= 2 # deazone will not drop the multiplier lower than this
var _scoreAccumValue:float = 0 #The value of accumulated multiplier increment - based on score
var _deadZoneElapsed = 0 #when this reaches
var _scoreMultiplier:int = 1 #this is the stage the multiplier is at


const RELOAD_TIME = 0.125 

# player invinvibility frames duration
export(float) var _invincibilityAmount = 2.5;
var _invincibilityTimer : float = 0;#the timer is set to the duration above. whilst in this state we are invulnerable/invincible

#speed management variables 
export(float) var _speed : float = 300  #normal speed of play
export(float) var _focusSpeed : = 50 	#speed refuced from focus
var _speedMultiplier:int = 1.0 		#speed multiplier - can be used to add speed boosts within the game
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
signal score_multiplier_changed


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
	_invincibilityTimer -= delta
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

	###########################################
	#     MULTIPLIER
	
	_deadZoneElapsed+=delta
	#drop 1 multiplier level if the player has not ggained new score in a while
	#this is to punish players for playing too passively and reward those who 
	#play more aggressively 
	var deadZoneScoreLimit = get_score_from_mult(_deadZoneMultDropLimit)
	if(_deadZoneElapsed >= _multiplierDeadZone && _scoreAccumValue > deadZoneScoreLimit):
		_scoreAccumValue=max(deadZoneScoreLimit,get_score_from_mult(_scoreMultiplier-1))
		_deadZoneElapsed = 0 #reset DeadZone timer
	

	var newMult = get_mult_from_accum(_scoreAccumValue)
	#print("scoreMultiplier[%s] _scoreAccum[%s]  scoreAccumMult[%s]"%[_scoreMultiplier,_scoreAccumValue,newMult])	
	if(newMult!=_scoreMultiplier):
		_set_score_multiplier(newMult)


# get a score value for the specified multiplier
func get_score_from_mult(mult:int)->int:
	return ((pow(2,mult)-2) * _scoreExpIncrementRate) as int

#get the multiplier for the accumulated score
func get_mult_from_accum(accumScore:float)->int:
	return floor(Globals.logB(accumScore/_scoreExpIncrementRate+2.0,2.0)) as int
	

#collision has started with something
func on_collision_start(area):
	#print_tree_pretty()
	var node = area.get_parent()
	print("collision with "+node.name+" detected!")


func hit(object):
	if ( _invincibilityTimer >= 0) :return 
	_scoreAccumValue = 0;#reset multiplier score accumulation 
	print("player is hit by =%s" % object.name)
	lives-=1
	var _value = Globals.audioManager.play_sound("sfx_playerHit")
	emit_signal("player_hit")
	_invincibilityTimer=_invincibilityAmount;

func _set_score(_score:int)->void:
	var _difference_value = _score-score;
	_scoreAccumValue+= _difference_value#add to accum
	_deadZoneElapsed = 0;#reset deadzone
	score += _difference_value*get_true_score_multiplier()
	emit_signal("score_changed")

func _set_score_multiplier(mult:int):
	print("score multiplier set to :%s ---------"%mult)
	_scoreMultiplier = mult;
	emit_signal("score_multiplier_changed",get_true_score_multiplier())

func get_true_score_multiplier()->float:
	return pow(_scoreMultiplierGrowth,_scoreMultiplier-1)

#use modulate to animate invincibility
func _animate_invincibility():
	if ( _invincibilityTimer >= 0) :# invinsibility
		#animation tweak START

		#dont touch this delta - it is used to get a value from 0 to 1 
		#it is dependant on _invincibilityAmount export variable
		var delta:float = 1-(_invincibilityTimer/_invincibilityAmount)
		
		#use this to tweak the frequency of the effect
		var freq:float = 30 #########
		##############################
		
		#use this to tweak the amount of fade - higher value means less fading happens
		# DO NOT EXCEED 1 - if 1 then there will be no effect
		var vShift = .65 ###
		####################

		#use these to set the color when fading
		var r:float = 1.0  #red
		var g:float = 0.0  #green
		var b:float = 0.0  #blue
		#######################################

		modulate = Color(r,g,b,(1.0-vShift)*cos(freq*delta)+vShift)

		#animation tweak END

	else : #no invinsibility
		#set everything back to normal
		modulate = Color(1,1,1,1);
		#############################



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

		
