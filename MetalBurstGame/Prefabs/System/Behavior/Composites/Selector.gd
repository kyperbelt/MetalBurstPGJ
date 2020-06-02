extends Composite

"""
Selector Behavior runs the behaviors in sequence but returns Success 
when the first child behavior posts a success state. Otherwise if no children
succeed, we return failure
"""

class_name Selector

var _finished:bool = false
var _current:int = 0
var _last:int = -1

func initiate():
	.initiate()
	_finished = false
	_current = 0
	_last = -1

func _update_behavior(delta:float)->int:
	var cBehaviors = get_child_behaviors()

	if(_finished):
		return RunState.Failed
	
	if(cBehaviors.size() == 0):
		_finished = true
	else:
	
		if(_current < cBehaviors.size()):

			var behavior : BehaviorNode = cBehaviors[_current]

			if(_current != _last): #check if node needs to be initiated this cycle
				behavior.initiate()
				_last = _current
			
			var result : int = behavior._update_behavior(delta)

			if(result == RunState.Success):
				return result
			elif(result == RunState.Failed):
				_current+=1
		else:
			_finished = true
	
	return RunState.Running

func get_child_behaviors():
	return .get_child_behaviors()

