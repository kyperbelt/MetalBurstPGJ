extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed : float = 200;
var screen_size      # size of the game window
var speed_reduced = 0

func start(pos):
	position = pos
	$Collisionshape2D.disabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Replace with function body.
	
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
	if !(Input.is_action_pressed("move_slower")):
		speed_reduced = 0
	translate(move*delta)
