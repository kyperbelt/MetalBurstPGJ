tool
extends Decorator

"""
This behavior makes any child behavior return success regardless of what the
childs actual RunState is. 
"""
class_name Succeeder

func initiate():
	.initiate()
	get_child_behavior().initiate()

func _update_behavior(delta:float)->int:
	var result: int = get_child_behavior()._update_behavior(delta)
	if(result!=RunState.Running):
		return RunState.Success
	return result

func _ready():
	pass # Replace with function body.

