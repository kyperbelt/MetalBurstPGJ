#Simple enemy ai that just goes down the screen
#at a predetermined speed and occasionally shoots at the player

extends Node2D

class_name Enemy

export(float) var speed = 100
export(float) var HP = 300
export(float) var DMGreceived = 100
#DMGreceived is meant to be temperary
#DMGreceived better placed in PlayerBullet

#export(AudioStreamPlayer) var FoeHitSFX
#export(AudioStreamPlayer) var FoeDeathSFX
export(PackedScene) var BULLET_TEST 
const ENEMY_BULLET = 1

const RELOAD_TIME = 0.1 

var reloading = 0.0
var my_engine
var shot_timer = 0
var cooldown = 0.2
var firing = false
var current_position_y = 0
var start_position_y = 0

var inEngine : bool = false #variable used to check if ai entity has been added to propper engine layer
	
func _ready():
	set_process(true)
	var _val = $EnemyArea.connect("area_entered", self, "hit")
	start_position_y = position.y

#called by the engine when it adds it to the correct layer
func engine_ready(engine):
	inEngine = true
	my_engine = engine;
	pass

func _process(delta):
	#check if the right Engine layer
	if(!inEngine):
		return
	translate(Vector2(0,speed * delta))
	reloading -= delta
	current_position_y = position.y
	if ((current_position_y - start_position_y) > 100):
		shoot()
		start_position_y = current_position_y

func hit(object):
	print("Enemy collision with " + object.name + " detected!")
	HP -= DMGreceived
	$FoeHitSFX.play()
	#HP-Threshold SFX can also be done here ; more advanced
	if HP <= 0:
		$FoeDeathSFX.play()
		queue_free()
	if object.name == 'PlayerCollisionArea':
		object.get_parent().hit(self)
		queue_free()

func shoot():
	#attempt to shoot if already placed in correct engine layer
	#otherwise return and do nothing
	if(!inEngine):
		return
	if reloading <= 0.0:
		var bullet = BULLET_TEST.instance()
		bullet.setProjectileType(ENEMY_BULLET)
		bullet.position = position
		#bullet.change_speed(speed)
		my_engine.add_child(bullet)
		shot_timer = cooldown
		reloading = RELOAD_TIME
