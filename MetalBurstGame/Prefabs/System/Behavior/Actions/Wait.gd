tool
extends Action

class_name Wait

const MINIMUM_DELAY : float = 0.00

export(float) var delay = 1.0 setget set_delay,get_delay

var _elapsed : float = 0

func initiate():
	.initiate()
	_elapsed = 0

func set_delay(d:float):
	delay = max(d,MINIMUM_DELAY)

func get_delay()->float:
	return delay

func _update_behavior(delta:float)->int:
	_elapsed+=delta
	if(_elapsed >= delay):
		return RunState.Success
	return RunState.Running

