extends Node2D


#player Select code
class_name PlayerSelect

export(Array,PackedScene) var playerTypes 

var _currentSelection :int =0 

func move_selection_left():
	pass #animate

func move_selection_right():
	pass #animate

func make_selection():
	Globals.Player = playerTypes[_currentSelection]
	pass
