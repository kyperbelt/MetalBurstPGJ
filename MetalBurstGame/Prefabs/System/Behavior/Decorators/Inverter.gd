extends Decorator

"""
Job of this behavior is to invert its child behavior's result. 
sort of like a logical NOT
"""

func initiate():
	.initiate()
	get_child_behavior().initiate()

func _update_behavior(delta:float)->RunState:

	var result : RunState = get_child_behavior()._update_behavior(delta)

	if(result == RunState.Failed):
		return RunState.Success
		
	if(result == RunState.Success):
		return RunState.Failed

	return result

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

