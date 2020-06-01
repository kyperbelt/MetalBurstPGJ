extends Composite

class_name Selector

var _finished:bool = false
var _current:int = 0
var _last:int = -1

func initiate():
	.initiate()
	_finished = false
	_current = 0
	_last = -1

func _update_behavior(delta:float)->RunState:
	
	return RunState.Running

