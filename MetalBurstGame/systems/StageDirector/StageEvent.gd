tool
extends Node2D

class_name StageEvent, "res://placeholder_assets/class_icons/StageEvent.png"

export(bool) var override_time
var event_time : float = 0;

func get_time():
    return self.event_time

func execute_event():
    return self.event_executable



func _ready():
    pass

func _process(_delta):
    print("hello")
    pass