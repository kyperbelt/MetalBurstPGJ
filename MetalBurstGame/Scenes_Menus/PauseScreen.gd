extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	set_process(false)



func show():
	.show()
	set_process(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func selection_made(selection: int):
	if!(is_visible_in_tree()):
		return
	match selection:
		0:	
			get_tree().paused = false;
			hide()
			set_process(false)
		1:
			var scene = "res://Scenes_Menus/TitleScreen.tscn"
			var result = get_tree().change_scene(scene)
			if(result != OK):
				print("could not change to scene %s" % scene)
			pass
		_: 
			print("%s is not a valid selection" % selection)
	pass
