tool
extends PositionalEvent

class_name EndStageEvent, "res://Assets/Tools/exit.png"

const EDITOR_DESC="""
This event is not based on position. Rather, it only 
needs to be placed in a stage director and will be executed
when the duration is exceeded. It will then transfer to the 
desired scene. You can specify if you want there to be an delay from
the time it executes. 
"""
#EXPORTS
export(String) var E_N_D = get_sep() setget set_sep,get_sep
func set_sep(_sep):
	update()
func get_sep():
	return ""
export(bool) var _stickyEnd = true
export var delay : float setget set_delay,get_delay
export(PackedScene) var Target


func _ready():
	if(Engine.editor_hint):
		set("editor_description",EDITOR_DESC)
		

func get_delay():
	return delay
	
func set_delay(time):
	delay = time if time > 0 else 0
	_y_changed()

func get_time():
	if(override_time):
		return event_time
	else:
		var sd : StageDirector = director as StageDirector
		return sd.duration if sd != null else 0

func _y_changed():
	if(!_stickyEnd):
		var sd = director as StageDirector
		position.y = sd.get_y_from_alpha((sd.duration+delay)/sd.duration) if sd!=null else position.y
		update()

func _process(_delta):
	if(Engine.editor_hint):
		update_y()
		

func _execute_event():
	
	engine.cleanup()
	var code = director.get_tree().change_scene_to(Target)
	if(code != OK):
		print("switching to [%s]" % Target)
	print("[END STAGE EVENT] executed")
	pass


