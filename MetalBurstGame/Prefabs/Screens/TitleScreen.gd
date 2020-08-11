extends Node2D


export(PackedScene) var PlayerSelect

export(PackedScene) var TestStage1
export(PackedScene) var TestStage2
export(PackedScene) var TestStage3


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
			Globals._selectedStage = TestStage1
		1:
			Globals._selectedStage = TestStage2
		2:
			Globals._selectedStage = TestStage3
		3:
			get_tree().quit()
		_:
			print("%s is not a valid selection" % selection)
	var _result = get_tree().change_scene_to(PlayerSelect)
	pass

