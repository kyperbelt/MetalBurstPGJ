tool
extends Action

class_name Wait

const MINIMUM_DELAY : float = 0.01

export(float) var delay = 1.0 setget set_delay,get_delay

var _elapsed : float = 0

func initiate():
	.initiate()
	_elapsed = 0

func set_delay(d:float):
	if(d < MINIMUM_DELAY):
		d = MINIMUM_DELAY
	delay = d

func get_delay()->float:
	return delay

func _update_behavior(delta:float)->int:
	_elapsed+=delta
	if(_elapsed >= delay):
		return RunState.Success

	return RunState.Running

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with
