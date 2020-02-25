extends Node2D

const RELOAD_TIME = 0.1 

export var speed : float = 300
var speed_reduced = 0

var play_area_width : int = 640
var play_area_height : int = 540
var reloading = 0.0
var pos
var direction
var parent
var shot_timer = 0
var cooldown = 0.2
var firing = false

class PlayerBullet extends "Projectile.gd".Projectile:
	func _init(_pos, _speed, _direction).(position, speed, direction):
		pass
	
	func _ready():
		set_texture(Globals.player_bullet_image)
	
	func _process(_delta):
		pass


# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	set_process(true)


func _process(delta):
	
	var move : Vector2 = Vector2(0,0);

	# shot_timer -= delta
	shot_timer = -1
	if Input.is_action_pressed("fire"):
		print("firing")
		if shot_timer <= 0:
			shoot()
			firing = true
		else:
			firing = false
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

	reloading -= delta

#collision has started with something
func on_collision_start(area):
	var node = area.get_parent()
	print("collision with "+node.name+" detected!")

func start(pos):
	position = pos
	$Collisionshape2D.disabled = false

func shoot():
	if reloading <= 0.0:
		#parent.get_node("sfx_player").play("shoot")
		var bullet = PlayerBullet.new(position + Vector2(0, -41), 1000, Vector2(0, -1))
		bullet.global_position = global_position
		bullet.change_speed(speed)
		parent.add_child(bullet)
		shot_timer = cooldown
		reloading = RELOAD_TIME
