extends Action

class_name Print

export(String) var message = "default message"

func initiate():
	.initiate()
	pass

func _update_behavior(_delta:float)->int:
	print(message)
	return RunState.Success
