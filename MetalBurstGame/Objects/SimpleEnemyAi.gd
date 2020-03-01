#Simple enemy ai that just goes down the screen
#at a predetermined speed and occasionally shoots at the player

extends Node2D

export(float) var speed = 100

const BULLET_TEST = preload("res://Objects/Projectiles.tscn")
const ENEMY_BULLET = 1

const RELOAD_TIME = 0.1 

var reloading = 0.0
var parent
var shot_timer = 0
var cooldown = 0.2
var firing = false
var current_position_y = 0
var start_position_y = 0

func _ready():
	set_process(true)
	parent = get_parent()
	$EnemyArea.connect("area_entered", self, "hit")
	start_position_y = position.y

func _process(delta):
	translate(Vector2(0,speed * delta))
	reloading -= delta
	current_position_y = position.y
	if ((current_position_y - start_position_y) > 100):
		shoot()
		start_position_y = current_position_y

func hit(object):
	print("Enemy collision with " + object.name + " detected!")
	if object.name == 'ProjectilesArea' || object.name == 'PlayerCollisionArea':
		queue_free()

func shoot():
	if reloading <= 0.0:
		var bullet = BULLET_TEST.instance()
		bullet.setProjectileType(ENEMY_BULLET)
		bullet.global_position = global_position
		#bullet.change_speed(speed)
		parent.add_child(bullet)
		shot_timer = cooldown
		reloading = RELOAD_TIME
