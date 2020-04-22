tool
extends PositionalEvent

class_name EndStageEvent, "res://placeholder_assets/tools/exit.png"

const EDITOR_DESC="""
This event is not based on position. Rather, it only 
needs to be placed in a stage director and will be executed
when the duration is exceeded. It will then transfer to the 
desired scene. You can specify if you want there to be an delay from
the time it executes. 
"""

export var offset : float setget set_offset,get_offset
export(PackedScene) var Target


func _ready():
	if(Engine.editor_hint):
		set("editor_description",EDITOR_DESC)
		

func get_offset():
	return offset
	
func set_offset(o):
	offset = o if o > 0 else 0
	_y_changed()

func get_time():
	if(override_time):
		return event_time
	else:
		var sd : StageDirector = director as StageDirector
		return sd.duration if sd != null else 0

func _y_changed():
	if(!override_time):
		var sd = director as StageDirector
		position.y = sd.get_y_from_alpha((sd.duration+offset)/sd.duration) if sd!=null else position.y
		update()

func _process(_delta):
	if(Engine.editor_hint):
		update_y()
		

func _execute_event():
	print("[END STAGE EVENT] executed")
	pass


