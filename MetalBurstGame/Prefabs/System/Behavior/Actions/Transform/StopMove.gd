extends Action
#Stop Movement
class_name StopMove

var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	pass

func _update_behavior(_delta:float)->int:
	if(_self):
		_self.set_velocity(0,0)
	
	return RunState.Success

