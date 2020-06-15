extends Action
#Action used to change the speed of an entity
#requires entity to have set_speed() function

class_name ChangeSpeed

#note that speed cannot exceed that of max_speed if the 
#entity has a get_max_speed function
#if no function is present then the check is ignored
export(float) var _speed = 0 setget set_speed

var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	if(_self.has_method("get_max_speed")):
		set_speed(min(_speed,_self.get_max_speed()))
	pass

func _update_behavior(_delta:float)->int:
	if(!_self.has_method("set_speed")):
		return RunState.Failed
	_self.set_speed(_speed)
	return RunState.Success

func set_speed(speed:float):
	_speed = max(speed,0)
