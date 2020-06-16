extends Node2D


export(PackedScene) var NEW_GAME_SCENE
export(PackedScene) var TestStage2

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.delete_player()
	get_tree().paused = false#just in case the game was paused
	pass # Replace with function body.

func selection_made(selection : int):
	print("selected option %s " % selection)
	$sfx_menuSelect.play()
	yield(get_tree().create_timer(2.0), "timeout")
	match selection:
		0:
			var result = get_tree().change_scene_to(NEW_GAME_SCENE)
			if(result != OK):
				print("could not change scene")
			pass
		1:
			var result = get_tree().change_scene_to(TestStage2)
			if(result != OK):
				print("could not change scene")
			pass
		2:
			get_tree().quit()
			pass
		_: 
			print("%s is not a valid selection" % selection)
	pass

