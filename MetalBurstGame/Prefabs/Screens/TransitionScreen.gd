extends Node2D

var PlayerScore = Globals.get_player().score

# Called when the node enters the scene tree for the first time.
func _ready():
	#Globals.delete_player()
	#ReimJ: Added to view score at GameOver
	$Score.set_text("%010d" % PlayerScore)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func selection_made(selection : int):
	print("selected option %s " % selection)
	match selection:
		0:
			var scene = "res://Prefabs/Stages/Stage2Mountainousv4.tscn"
			var result = get_tree().change_scene(scene)
			pass
	pass

func _on_OptionsMenu_focus_entered():
	$TitleAudioStreamPlayer.play()
