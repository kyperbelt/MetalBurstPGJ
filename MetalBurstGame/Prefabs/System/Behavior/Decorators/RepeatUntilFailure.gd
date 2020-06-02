extends Decorator

"""
Functionally almost the same as the Repeater, but instead of repeating a
set amount of times(or forever), we will keep repeating until failure
"""
class_name RepeatUntilFail

var _finished : bool = false

func initiate():
	.initiate()
	get_child_behavior().initiate()
	_finished = false

func _update_behavior(delta:float)->RunState:
	
	if( _finished):
		_finished = false
		get_child_behavior().initiate()
	
	var result : RunState = get_child_behavior()._update_behavior(delta)

	if(result != RunState.Running && result != RunState.Failed):
		_finished = true
	else:
		return result

	return RunState.Running

func _ready():
	pass # Replace with function body.
