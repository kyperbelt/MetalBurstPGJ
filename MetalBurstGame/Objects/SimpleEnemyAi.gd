#Simple enemy ai that just goes down the screen
#at a predetermined speed and occasionally shoots at the player

extends Node2D

export(float) var speed = 100

func _ready():
	set_process(true)

func _process(delta):
	translate(Vector2(0,speed * delta))
