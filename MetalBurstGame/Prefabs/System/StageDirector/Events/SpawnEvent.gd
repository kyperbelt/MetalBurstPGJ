tool
extends PositionalEvent

class_name SpawnEvent, "res://Assets/Tools/entity.png"

#SIGNALS

#EXPORTS
export(String) var S_P_A_W_N = get_sep() setget set_sep,get_sep
func set_sep(_sep):
	update()
func get_sep():
	return ""
export(float) var spawn_x = 0 setget set_spawn_x,get_spawn_x

#VARS
var entities = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		update()
	

func _on_event_added():
	var children = get_children()

	for child in children:
		print(child.get_class())
		if(child.is_class("Enemy")):
			print("added ")
			entities.append(child)
			remove_child(child)
			
func _execute_event():
	var entity_layer = engine.get_node("EntityLayer")
	for entity in entities:
		var new_x = spawn_x + entity.position.x + director.get_offset()
		#the y position is always relative to the top of the stage screen
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
	

func _process(_delta):
	if(Engine.editor_hint):
		if(spawn_x!=position.x):
			spawn_x = position.x
		update_y()

