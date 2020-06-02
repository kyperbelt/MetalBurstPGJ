extends Decorator

func initiate():
	.initiate()
	get_child_behavior().initiate()

func _update_behavior(delta:float)->RunState:
	var result: RunState = get_child_behavior()._update_behavior(delta)
	if(result!=RunState.Running):
		return RunState.Success
	return result

func _ready():
	pass # Replace with function body.

