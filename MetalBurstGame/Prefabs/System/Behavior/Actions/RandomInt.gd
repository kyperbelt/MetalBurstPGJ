extends Action

#sets a random int to the blackboard
class_name RandomInt

#range
export(int) var _min = 0
export(int) var _max = 8

#num
var _num : int = 0

#name
export(String) var _name = "randomInt"

func initiate():
	.initiate()
	_num = Globals.random.randi_range(_min,_max)

func _update_behavior(_delta:float)->int:
	get_blackboard()[_name] = _num
	return RunState.Success

