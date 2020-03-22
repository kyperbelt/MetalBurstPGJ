extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false#just in case the game was paused
	pass # Replace with function body.

func selection_made(selection : int):
	print("selected option %s " % selection)
	match selection:
		0:
			var result = get_tree().change_scene("res://Stages/TestStage.tscn")
			if(result != OK):
				print("could not change scene")
			pass
		1:
			print("option %s is not yet implemented!" % selection)
			pass
		2:
			get_tree().quit()
			pass
		_: 
			print("%s is not a valid selection" % selection)
	pass
