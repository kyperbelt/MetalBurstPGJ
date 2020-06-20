extends Action

class_name ShootDown

var _self = null
var _canShoot : bool = false
func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	if(_self.has_method("shoot")):
		_canShoot = true
	pass

func _update_behavior(_delta:float)->int:
	if(!_canShoot):
		return RunState.Failed
	
	_self.shoot()
	return RunState.Success

