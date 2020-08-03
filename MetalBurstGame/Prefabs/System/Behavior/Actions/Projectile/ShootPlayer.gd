extends Action

class_name ShootPlayer

export(float) var _speed = 280
export(float) var _angleOffset = 0;

var _self = null
var _engine = null
var _player = null
var _projectile:ProjectileComponent = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	_player = get_blackboard()[BB.PLAYER]
	var defaultProjectile = get_blackboard()[BB.DPROJECTILE]
	_projectile = defaultProjectile.instance() if defaultProjectile!=null else Globals.DefaultProjectile.instance()

func _update_behavior(_delta:float)->int:
	var sp : Vector2 = _self.global_position
	var pp : Vector2 = _player.global_position

	var _angle : float = atan2(pp.y - sp.y, pp.x -sp.x)-PI/2

	ShootAngle.shoot(_speed,_angle + (_angleOffset * (PI/180)),_self,_engine,_projectile)
	return RunState.Success


