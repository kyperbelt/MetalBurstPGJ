extends Decorator

"""
Repeat the child behavior for the specified amount of times.
If the amount is set to something negative then the behavior
will repeat endlessly
"""

#properties
export(int) var amount = -1 #repeat endlessly by default

var _finished:bool = false
var _timesRan:int = 1

func initiate():
	.initiate()
	pass

func _update_behavior(delta:float)->RunState:

	if(_finished):
		_finished = false
		get_child_behavior().initiate()
		_timesRan+=1

	var result : RunState = get_child_behavior()._update_behavior(delta)

	if(_timesRan >= amount && amount > 0):
		return result

	if(result != RunState.Running):
		_finished = true
	return RunState.Running

func _ready():
	pass # Replace with function body.
