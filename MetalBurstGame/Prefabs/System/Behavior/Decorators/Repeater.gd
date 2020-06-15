tool
extends Decorator

"""
Repeat the child behavior for the specified amount of times.
If the amount is set to something negative then the behavior
will repeat endlessly
"""
class_name Repeater

#properties
export(int) var amount = -1 #repeat endlessly by default

var _finished:bool = false
var _timesRan:int = 1

func initiate():
	.initiate()
	get_child_behavior().initiate()
	_finished = false
	_timesRan = 1
	pass

func _update_behavior(delta:float)->int:
	if(_finished):
		_finished = false
		get_child_behavior().initiate()
		_timesRan+=1

	var result : int = get_child_behavior()._update_behavior(delta)

	if(_timesRan >= amount && amount > 0):
		return result

	if(result != RunState.Running):
		_finished = true
	return RunState.Running

