extends Action
##  rotate by the given angle ammount
##  in the designated amount of time
### set time to 0 for instant angle shift
#Owner must be Node2d or have the following functions to work
#get_rotation_degrees()
#set_rotation_degrees()
class_name RotateBy

export(float) var _angle = 0
export(float) var _time = 0 
var _elapsed:float = 0

var _self = null
var _initial_angle:float = 0

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_initial_angle = _self.get_rotation_degrees()
	_elapsed = 0
	pass

func _update_behavior(delta:float)->int:
	
	_elapsed+=delta
	
	var a = 1.0 if _time <= 0 else min(_elapsed/_time,1)
	
	_self.set_rotation_degrees(_initial_angle + a * ((_initial_angle+_angle) - _initial_angle))
	
	if(_elapsed>=_time):
		return RunState.Success
	return RunState.Running


