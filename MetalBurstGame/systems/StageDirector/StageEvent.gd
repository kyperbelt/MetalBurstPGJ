extends Node2D

class_name StageEvent, "res://placeholder_assets/class_icons/StageEvent.png"

export(float)var event_time setget set_time,get_time

onready var director = get_parent()

var engine #same engine that houses the layers | not to be confused with godot's internal ENGINE

func _ready():
	
	director.connect("timeline_changed",self,"_on_timeline_change")

#override - called when the timeline has changed either in duration or scale
func _on_timeline_change():
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
	pass

func get_sep():
	return ""

#called when event is added to the stage director
func _on_event_added():
	pass
	

