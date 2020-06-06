tool
extends Decorator

"""
Job of this behavior is to invert its child behavior's result. 
sort of like a logical NOT
"""
class_name Inverter

func initiate():
	.initiate()
	get_child_behavior().initiate()

func _update_behavior(delta:float)->int:
	var result : int = get_child_behavior()._update_behavior(delta)
	if(result == RunState.Failed):
		return RunState.Success
	if(result == RunState.Success):
		return RunState.Failed
	return result

