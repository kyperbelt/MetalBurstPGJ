tool
extends StageEvent

class_name SpawnEvent, "res://placeholder_assets/tools/entity.png"

#SIGNALS

#Exports
export(bool) var override_time = false
export(float) var spawn_x = 0 setget set_spawn_x,get_spawn_x


#VARS
var prev_y = NAN
var alpha :float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		update()
	
func _on_timeline_change():
	if(!override_time):
		var sd : StageDirector = director as StageDirector
		alpha = sd.get_alpha_from_time(event_time)
		position.y = sd.get_y_from_alpha(alpha)
		prev_y = position.y
		set_time_using_alpha(sd.duration)
		
		#print("timeline changed - position updated")
		update()
		
func set_time_using_alpha(duration):
	var temp = override_time
	override_time = true
	event_time = duration * alpha
	override_time = temp
	

func _execute_event():
	print("SpawnEvent=[event_time:%s spawn_x:%s]" % [event_time,spawn_x])
	pass

func set_spawn_x(x):
	spawn_x = x
	position.x = spawn_x

func get_spawn_x():
	return spawn_x
	

func set_time(time):
	if(override_time):
		.set_time(time)

func _process(_delta):
	if(Engine.editor_hint):
		if(spawn_x!=position.x):
			spawn_x = position.x
		if(!override_time && position.y != prev_y):
			prev_y = position.y
			var sd : StageDirector = director as StageDirector
			var ypos = position.y
			alpha = sd.get_alpha_from_y(position.y)
			set_time_using_alpha(sd.duration)
			print("ypos %s | alpha %s " % [ypos, alpha])
			pass	


