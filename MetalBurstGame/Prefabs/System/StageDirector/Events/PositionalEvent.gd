tool
extends StageEvent

#Stage event that auto adjusts itself based on timeline
#changes.
class_name PositionalEvent, "res://Assets/Tools/pointA.png"

#SIGNALS

#EXPORTS
export(String) var P_O_S_I_T_O_N = get_sep() setget set_sep,get_sep
func set_sep(_sep):
	update()
func get_sep():
	return ""
	#if true ignores the positional based timing.
export(bool) var override_time = false


#VARS
var prev_y = NAN

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		update()
	
func _on_timeline_change(duration_changed:bool):
	if(!override_time):
		var sd : StageDirector = director as StageDirector
		var alpha = 1
		if(!duration_changed):
			alpha = sd.get_alpha_from_time(event_time)
		else:
			if sd._preserveTimings:
				alpha = sd.get_alpha_from_time(event_time)
			else:
				alpha = sd.get_alpha_from_y(position.y)
		position.y = sd.get_y_from_alpha(alpha)
		prev_y = position.y
		set_time_using_alpha(sd.duration,alpha)
		
		#print("timeline changed - position updated")
		update()
		
func set_time_using_alpha(duration,alpha):
	var temp = override_time
	override_time = true
	event_time = duration * alpha
	override_time = temp
	



func set_time(time):
	if(override_time):
		.set_time(time)

func get_time():
	if(override_time):
		return .get_time()
	else:
		var sd : StageDirector = director as StageDirector
		var alpha = sd.get_alpha_from_y(position.y) if sd != null else 1
		return (director.duration if director != null else 1) * alpha

#update the y position in the timeline 
#based on the event time
func update_y():
	if(Engine.editor_hint):
		if(!override_time && position.y != prev_y):
			prev_y = position.y
			var sd : StageDirector = director as StageDirector
			var alpha = sd.get_alpha_from_y(position.y) if sd != null else 1
			set_time_using_alpha(sd.duration if sd != null else 1,alpha)
			_y_changed()
			

#called when y position was changed
func _y_changed():
	pass

func _process(_delta):
	pass
	



