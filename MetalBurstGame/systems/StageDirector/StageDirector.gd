tool
extends Node2D


#PRELOAD
const StageEvent = preload("res://systems/StageDirector/StageEvent.gd")
const END_NODE = preload("res://systems/StageDirector/Indicators/END.tscn")

#SIGNALS
signal duration_exceeded #Duration of level exeeded

#EDITOR NODES
onready var start = $START
onready var end = $END

#EXPORT OPTIONS
export(float,10.0,600.0) var stage_duration
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
		set("editor_description","HelloWorld")
		end.connect("position_changed",self,"end_position_changed")
		end_position_changed()
		if(end.position == start.position):
			end.position = Vector2(start.position.x,start.position.y - 1000)
		
	else:
		set_process(true)
	pass # Replace with function body.

func _draw():
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
		pass
	

func end_position_changed():
	if(end.position.y >= start.position.y - 1000):
		end.position.y = start.position.y - 1000
	end_position = Vector2(end.position)
	start_position = Vector2(start.position)
	update()
	
	
func _process(delta):
	if(Engine.editor_hint):
		#in editor
		position_to_viewport()
		pass
	else:
		#in game
		elapsed+=delta
		if(elapsed > stage_duration):
			emit_signal("duration_exceeded")

		for i in range(len(stage_events),0):
			if elapsed > stage_events[i].get_time():
				stage_events[i].execute()
				stage_events.remove(i)

	
func add_stage_event(event):
	stage_events.append(event)
	
	
func position_to_viewport():
	if(!LevelScene.is_empty()):
		var level = get_node(LevelScene)
		var container = level.get_node("Container")
		var c_pos = container.rect_position
		var c_size = container.rect_size
		position = Vector2(c_pos.x + c_size.x / 2, c_pos.y + c_size.y)


