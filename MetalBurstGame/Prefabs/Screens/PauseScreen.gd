extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var _soundSettings

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
			if _soundSettings:
				_soundSettings.show()
				get_parent().move_child(_soundSettings,get_parent().get_child_count()-1)
		2:
			var scene = "res://Prefabs/Screens/TitleScreen.tscn"
			var result = get_tree().change_scene(scene)
			if(result != OK):
				print("could not change to scene %s" % scene)
			pass
		_: 
			print("%s is not a valid selection" % selection)
	pass
