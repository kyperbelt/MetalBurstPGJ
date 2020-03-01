extends Node2D

const BULLET_PROJECTILE = preload("res://Objects/Projectiles.tscn")

enum PROJECTILES {
	PLAYER_BULLET,
	PLAYER_BOMB = 2
	
}
const RELOAD_TIME = 0.1 

export var speed : float = 300
var speed_reduced = 0

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

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	set_process(true)


func _process(delta):
	
	var move : Vector2 = Vector2(0,0);

	# shot_timer -= delta
	shot_timer = -1
	bomb_timer -= delta
	if Input.is_action_pressed("fire"):
		print("firing")
		if shot_timer <= 0:
			shoot()
			firing = true
		else:
			firing = false
	if Input.is_action_pressed("player_bomb"):
		print("bombing")
		if bomb_timer <= 0:
			bomb_away()
			bombing = true
		else:
			bombing = false
	if Input.is_action_pressed("move_up"):
		move.y-=speed + speed_reduced
	if Input.is_action_pressed("move_down"):
		move.y+=speed + speed_reduced
	if Input.is_action_pressed("move_left"):
		move.x-=speed + speed_reduced
	if Input.is_action_pressed("move_right"):
		move.x+=speed + speed_reduced
	if Input.is_action_pressed("move_slower"):
		speed_reduced = -150
	else:
		speed_reduced = 0
	translate(move*delta)
	
	if(position.x < 0) : position.x = 0
	if(position.x > play_area_width) : position.x = play_area_width
	if(position.y < 0) : position.y = 0;
	if(position.y > play_area_height): position.y = play_area_height

	bullet_reloading -= delta
	bomb_reloading -= delta

#collision has started with something
func on_collision_start(area):
	#print_tree_pretty()
	var node = area.get_parent()
	print("collision with "+node.name+" detected!")

func start(pos):
	position = pos
	$Collisionshape2D.disabled = false

func shoot():
	if bullet_reloading <= 0.0:
		var bullet = BULLET_PROJECTILE.instance()
		bullet.setProjectileType(PROJECTILES.PLAYER_BULLET)
		bullet.global_position = global_position
		#bullet.change_speed(speed)
		parent.add_child(bullet)
		shot_timer = cooldown
		bullet_reloading = RELOAD_TIME

func bomb_away():
	if bomb_reloading <= 0.0:
		var bomb = BULLET_PROJECTILE.instance()
		bomb.setProjectileType(PROJECTILES.PLAYER_BOMB)
		bomb.global_position = global_position
		#bullet.change_speed(speed)
		parent.add_child(bomb)
		bomb_timer = bomb_cooldown
		bomb_reloading = RELOAD_TIME
