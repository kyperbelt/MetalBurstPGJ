
tool
extends Node2D

const EDITOR_DESC = \
"""Stage Director in charge of executing events that control
the flow of the game.
These include but are not limited to spawning enemies, displaying alerts,
and even ending the level/stage if it has taken too long. 
 

@jonathan camarena
"""

class_name StageDirector, "res://placeholder_assets/tools/director.png"

#CONSTS
const StageEvent = preload("res://systems/StageDirector/StageEvent.gd")
const END_NODE = preload("res://systems/StageDirector/Indicators/END.tscn")



#SIGNALS
signal duration_exceeded #Duration of level exeeded
signal timeline_changed #the position of the timeline was moved so children must recalculate themselves accordingly

#EDITOR NODES
onready var start = $START
onready var end = $END

#EXPORT OPTIONS
export(bool) var display_timeline = true
export(float,10.0,600.0) var duration
export(NodePath) var LevelScene
export(int) var hatch_marks = 3

#CLASS VARIABLES
var elapsed : float = 0.0;
var stage_events = []
var end_position : Vector2  = Vector2(0,0)
var start_position : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		#IN EDITOR 
		set("editor_description",EDITOR_DESC)
		end.connect("position_changed",self,"end_position_changed")
		
		end_position = Vector2(end.position)
		start_position = Vector2(start.position)
		if(end.position == start.position):
			end.position = Vector2(start.position.x,start.position.y - 1000)
		
	else:
		#IN GAME
		start.set_visible(false)
		end.set_visible(false)
		set_process(true)
		add_all_events_to_queue()

func _draw():
	if(Engine.editor_hint):
		if !LevelScene.is_empty():
			var level = get_node(LevelScene)
			var container = level.get_node("Container")
			var c_pos = Vector2(container.rect_position.x-position.x,container.rect_position.y)
			var c_size = container.rect_size
			draw_rect(Rect2(c_pos,c_size),Color.black,true)
		
		if(display_timeline):
			draw_line(Vector2(start_position), Vector2(start_position.x,end_position.y), Color.white, 4, true)
			draw_line(Vector2(start_position.x,end_position.y), Vector2(end_position), Color.red, 6, true)
			var hatchpos = Vector2(0,0)
			var hatch_len = 100
			var hatch_color = Color.red
			var hatch_width = 4
			var distance = end_position.y - start_position.y
			var hatch_dist = distance/(hatch_marks+1)
			for i in range(hatch_marks):
				var index = i+1
				hatchpos = Vector2(start_position.x,end_position.y-hatch_dist*index)
				draw_line(Vector2(hatchpos.x-hatch_len/2,hatchpos.y), Vector2(hatchpos.x+hatch_len/2,hatchpos.y), hatch_color, hatch_width, true)
		

func end_position_changed():
	if(end.position.y >= start.position.y - 1000):
		end.position.y = start.position.y - 1000
	end_position = Vector2(end.position)
	start_position = Vector2(start.position)
	emit_signal("timeline_changed")
	update()
	
	
func _process(delta):
	if(Engine.editor_hint):
		#IN_EDITOR
		position_to_viewport()
		pass
	else:
		#in game
		elapsed+=delta
		if(elapsed > duration):
			emit_signal("duration_exceeded")

		#print("events size %s | elapsed time : %s | duration: %s" % [len(stage_events),elapsed,duration])
		for event in stage_events:
			if elapsed > event.get_time():
				event._execute_event()
				stage_events.erase(event)

func get_alpha_from_time(time):
	return time / duration

func get_dist():
	return end.position.y - start.position.y

func get_y_from_alpha(alpha):
	return get_dist() * alpha

func get_alpha_from_y(ypos):
	return ypos / get_dist()

func add_stage_event(event):
	stage_events.append(event)


func add_all_events_to_queue():
	for child in get_children():
		if(child is StageEvent):
			print(child.get_name()," added to StageEventQueue")
			add_stage_event(child)
			remove_child(child)
			pass
	
func position_to_viewport():

	if(Engine.editor_hint && !LevelScene.is_empty()):
		var level = get_node(LevelScene)
		var container = level.get_node("Container")
		var c_pos = container.rect_position
		var c_size = container.rect_size
		position = Vector2(c_pos.x + c_size.x / 2, c_pos.y )


