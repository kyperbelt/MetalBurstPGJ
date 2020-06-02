extends Composite


"""
A sequence Runs all the children in sequence and returns success only 
when all its child behaviors post success. Otherwise it will return Failure
at the first Failed post by a child behavior. 
"""
class_name Sequence

var _finished:bool = false
var _current:int = 0
var _last:int = -1

func initiate():
	.initiate()
	_finished = false
	_current = 0
	_last = -1
	

func _update_behavior(delta:float)->RunState:
	var childBehaviors = get_child_behaviors()
	if(_finished):
		return RunState.Success
	if(childBehaviors.size() == 0):
		_finished = true
	else:
		if(_current < childBehaviors.size()):
			var currentChild = childBehaviors[_current]
			if(_current != _last):
				currentChild.initiate()
				_last = _current
			var resultState : RunState = currentChild._update_behavior(delta)
			if(resultState == RunState.Failed):
				return resultState
			elif(resultState == RunState.Success):
				_current+=1
		else:
			_finished=true
				
	return RunState.Running
	
