extends Node2D

#This file contains important global information and functions
#that can be accessed from anywhere in the program at any given 
#time by calling Globals.something. 
var screen_size
var margin = 80
var player_bullet_image
const Player : PackedScene = preload("res://Prefabs/Player/Player.tscn")
var _player = null

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	player_bullet_image = preload("res://Assets/Projectiles/bullet.png")


func get_player():
	if(_player == null):
		_player = Player.instance()
		print("new player created")
	print("player returned from globals")
	return _player

func delete_player():
	print("player deleted")
	_player = null


func repeat_string(s:String,times:int)->String:
	var s2 = ""
	for _i in range(times):
		s2+=s
	return s2
