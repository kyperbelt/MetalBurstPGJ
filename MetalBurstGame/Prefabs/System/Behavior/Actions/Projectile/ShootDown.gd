extends Action

class_name ShootDown

export(float) var _speed = 300

var _self = null
var _engine = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]

func _update_behavior(_delta:float)->int:
	shoot()
	return RunState.Success

func shoot():
	var bullet : BulletTest = Globals.Bullet.instance()
	bullet.setProjectileType(1)# 1 = ENEMY_BULLET
	bullet.position = _self.position
	bullet.set_speed(_speed)
	bullet.set_velocity(0,1)
	#bullet.change_speed(speed)
	_engine.add_child(bullet)
