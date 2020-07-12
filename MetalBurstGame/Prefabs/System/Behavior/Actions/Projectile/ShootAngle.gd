extends Action

class_name ShootAngle

export(float) var _speed = 280
export(float) var _angle = 0

var _self = null
var _engine = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]

func _update_behavior(_delta:float)->int:
	
	
	var angle : float = _angle * (PI/180)
	
	shoot(_speed,angle,_self,_engine)
	return RunState.Success


static func shoot(speed:float,angle:float,entity:Node2D,engine):
	var bullet : BulletTest = Globals.Bullet.instance()
	var _realAngle = angle + PI/2
	bullet.setProjectileType(1)# 1 = ENEMY_BULLET
	bullet.position = entity.position
	bullet.set_speed(speed)
	bullet.set_velocity(cos(_realAngle),sin(_realAngle))
	#bullet.change_speed(speed)
	engine.add_child(bullet)
	var _value = Globals.audioManager.play_sound("sfx_menuSelect")
