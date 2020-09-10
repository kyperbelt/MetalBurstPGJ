extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var stage_engine = $Container/PlayArea/Engine

export(NodePath) var _soundSettingsPath

# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/PlayArea.update_size($Container.rect_size.x,$Container.rect_size.y)
	$Container/PlayArea/Engine.pre_process_entities()
	$Container/PlayArea/Engine.set_info_display(get_node("InformationDisplay"))

	$PauseScreens._soundSettings = get_node(_soundSettingsPath)


