tool
extends Composite

## A node that runs all its child nodes in parallel and returns Failed if any of
## its children fail, but doesnt stop running until all child nodes finish. 
## Returns Success if all children succeed. 

class_name Parallel

var _finished : bool = false
var _returnState : int = RunState.Running

func initiate():
	.initiate()
	for child in get_child_behaviors():
		child.initiate()
	pass

func _update_behavior(delta:float)->int:
	
	if(_finished):
		return _returnState
	_returnState = RunState.Failed
	var _run : int = 0
	var _fail : int = 0
	for child in get_child_behaviors():
		var rs = child._update_behavior(delta)
		if (rs == RunState.Running):
			_run+=1
		if(rs == RunState.Failed):
			_fail+=1
	if(_fail==0):
		_returnState = RunState.Success
	if(_run == 0):
		_finished = true
	return RunState.Running
