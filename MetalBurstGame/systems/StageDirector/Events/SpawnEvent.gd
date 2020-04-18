tool
extends StageEvent

class_name SpawnEvent, "res://placeholder_assets/tools/entity.png"

#SIGNALS

#Exports
export(bool) var override_time = false
export(float) var spawn_x = 0 setget set_spawn_x,get_spawn_x


#VARS
var prev_y = NAN
var entities = []
var engine #same engine that houses the layers | not to be confused with godot's internal ENGINE


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		update()
	
func _on_timeline_change():
	if(!override_time):
		var sd : StageDirector = director as StageDirector
		var alpha = sd.get_alpha_from_time(event_time)
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

func _on_event_added():
	var children = get_children()
	for child in children:
		if(child is Enemy):
			entities.append(child)
			remove_child(child)
	pass

func _execute_event():
	var entity_layer = engine.get_node("EntityLayer")
	for entity in entities:
		var new_x = spawn_x + director.get_offset()
		var new_y = director.position.y+entity.position.y
		entity.position = Vector2(new_x,new_y)
		entity_layer.add_child(entity)
		entity.engine_ready(engine)
		print("SpawnEvent=[event_time:%s spawn_x:%s spawn_y=%s]" % [get_time(),new_x,new_y])
	entities.clear()
	pass

func set_spawn_x(x):
	spawn_x = x
	position.x = spawn_x

func get_spawn_x():
	return spawn_x
	

func set_time(time):
	if(override_time):
		.set_time(time)

func get_time():
	if(override_time):
		return .get_time()
	else:
		var sd : StageDirector = director as StageDirector
		var alpha = sd.get_alpha_from_y(position.y)
		return director.duration * alpha

func _process(_delta):
	if(Engine.editor_hint):
		if(spawn_x!=position.x):
			spawn_x = position.x
		if(!override_time && position.y != prev_y):
			prev_y = position.y
			var sd : StageDirector = director as StageDirector
			var ypos = position.y
			var alpha = sd.get_alpha_from_y(position.y)
			set_time_using_alpha(sd.duration,alpha)
			print("ypos %s | alpha %s " % [ypos, alpha])
			pass	


