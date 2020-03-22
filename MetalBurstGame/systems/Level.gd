extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/PlayArea.update_size($Container.rect_size.x,$Container.rect_size.y)
	$Container/PlayArea/Engine.pre_process_entities()
	pass # Replace with function body.




func _on_Level_tree_entered():
	$LevelOneAudioStreamPlayer.play()


func _on_Level_tree_exited():
	$LevelOneAudioStreamPlayer.stop()
