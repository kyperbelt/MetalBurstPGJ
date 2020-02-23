
#This file contains important global information and functions
#that can be accessed from anywhere in the program at any given 
#time by calling Globals.something. 


extends Node


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)


