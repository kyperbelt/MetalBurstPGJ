extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var stage_engine = $Container/PlayArea/Engine

# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/PlayArea.update_size($Container.rect_size.x,$Container.rect_size.y)
	$Container/PlayArea/Engine.pre_process_entities()
	$Container/PlayArea/Engine.set_info_display(get_node("InformationDisplay"))


func _on_Level_tree_entered():
	$bgm_testStage2.play()


func _on_Level_tree_exited():
	$bgm_testStage2.stop()
