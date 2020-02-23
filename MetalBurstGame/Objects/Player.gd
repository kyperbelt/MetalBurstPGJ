extends Node2D

export var speed : float = 300
var speed_reduced = 0

var play_area_width : int = 640
var play_area_height : int = 540


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


func _process(delta):
	
	var move : Vector2 = Vector2(0,0);
	
	if Input.is_action_pressed("fire"):
		print("firing")
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

#collision has started with something
func on_collision_start(area):
	var node = area.get_parent()
	print("collision with "+node.name+" detected!")

func start(pos):
	position = pos
	$Collisionshape2D.disabled = false
