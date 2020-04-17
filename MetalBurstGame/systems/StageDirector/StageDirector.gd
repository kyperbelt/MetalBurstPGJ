tool
extends Node2D

const StageEvent = preload("res://systems/StageDirector/StageEvent.gd")

signal duration_exceeded

export(float,10.0,600.0) var stage_duration
 
var elapsed : float = 0.0;

var stage_events = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		pass
	else:
		set_process(true)
	pass # Replace with function body.

func _draw():
	print("drawing")

func _process(delta):
	if(Engine.editor_hint):

		#in editor
		
		update()
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


