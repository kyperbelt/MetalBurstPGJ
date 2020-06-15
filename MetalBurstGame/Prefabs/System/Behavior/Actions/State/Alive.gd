extends Action

#use this to check if the entity is alive
#requires the control to have a get_current_health() function
class_name Alive

export(String) var message = "default message"

var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	pass

func _update_behavior(_delta:float)->int:
	if(_self.has_method("get_current_health") && _self.get_current_health() > 0):
		return RunState.Success
	return RunState.Failure


