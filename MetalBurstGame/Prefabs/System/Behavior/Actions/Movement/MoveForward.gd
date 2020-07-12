extends Action
# move the entity towards its forward direction - this is related to its 
# angle
## This requires that the owner is a Node2D or/and has the following functions:
## get_rotation() function 
## set_velocity(x,y)

class_name MoveForward

var _failed : bool = false #check to see if method is present
var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_failed = !_self.has_method("get_rotation")

func _update_behavior(_delta:float)->int:
	
	var r : float = _self.get_rotation()+PI/2
	var x : float = cos(r)
	var y : float = sin(r)
	_self.set_velocity(x,y)
	return RunState.Success
