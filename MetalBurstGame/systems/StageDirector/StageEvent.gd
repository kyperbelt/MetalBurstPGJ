tool
extends Node2D

class_name StageEvent, "res://placeholder_assets/class_icons/StageEvent.png"

export(float)var event_time setget set_time,get_time

onready var director = get_parent()



func _ready():
	director.connect("timeline_changed",self,"_on_timeline_change")

#override - called ehwn the timeline has changed either in duration or scale
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

#called when event is added to the stage director
func _on_event_added():
	pass
	

