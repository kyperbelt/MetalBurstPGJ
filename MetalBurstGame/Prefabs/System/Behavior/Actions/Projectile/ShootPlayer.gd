extends Action

class_name ShootPlayer

export(float) var _speed = 280

var _self = null
var _engine = null
var _player = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	_player = get_blackboard()[BB.PLAYER]

func _update_behavior(_delta:float)->int:
	
	var sp : Vector2 = _self.global_position
	var pp : Vector2 = _player.global_position
	
	var _angle : float = atan2(pp.y - sp.y, pp.x -sp.x)-PI/2
	
	ShootAngle.shoot(_speed,_angle,_self,_engine)
	return RunState.Success


