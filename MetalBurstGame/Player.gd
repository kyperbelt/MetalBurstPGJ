extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed : float = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


func _process(delta):
	
	var move : Vector2 = Vector2(0,0);
	
	if Input.is_action_pressed("fire"):
		print("firing")
	if Input.is_action_pressed("move_up"):
		move.y-=speed 
	if Input.is_action_pressed("move_down"):
		move.y+=speed
	if Input.is_action_pressed("move_left"):
		move.x-=speed
	if Input.is_action_pressed("move_right"):
		move.x+=speed
	translate(move*delta)
