extends Node2D

export(PackedScene) var TITLE_SCREEN

var GameOverScore = Globals.get_player().score

# Called when the node enters the scene tree for the first time.
func _ready():
	#ReimJ: Added to view score at GameOver
	$Score.set_text("%010d" % GameOverScore)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func selection_made(selection : int):
	print("selected option %s " % selection)
	match selection:
		0:
			var scene = "res://Prefabs/Stages/Stage1Forest(Base).tscn"
			var result = get_tree().change_scene(scene)
			if(result != OK):
				print("could not change scene")
			pass
		1:
			var scene = "res://Prefabs/Screens/TitleScreen.tscn"
			var result = get_tree().change_scene(scene)
			if(result != OK):
				print("could not change to scene %s" % TITLE_SCREEN.resource_path)
			pass
		_:
			print("%s is not a valid selection" % selection)
	pass

func _on_OptionsMenu_focus_entered():
	$TitleAudioStreamPlayer.play()
