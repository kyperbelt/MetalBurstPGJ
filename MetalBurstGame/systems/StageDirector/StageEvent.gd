tool
extends Node2D

class_name StageEvent, "res://Assets/Tools/open.png"

#EXPORT
export(String) var B_A_S_E = get_sep() setget set_sep,get_sep
export(float)var event_time setget set_time,get_time

onready var director = get_parent()

var engine #same engine that houses the layers | not to be confused with godot's internal ENGINE

func _ready():
	
	director.connect("timeline_changed",self,"_on_timeline_change")

#override - called when the timeline has changed either in duration or scale
# warning-ignore:unused_argument
func _on_timeline_change(duration_changed:bool):
	pass

func set_time(time):
	event_time = time

func get_time():
	return event_time

func _execute_event():
	pass
	
func _process(_delta):
	pass

func set_sep(_sep):
	update()
func get_sep():
	return ""

#called when event is added to the stage director
func _on_event_added():
	pass
	

