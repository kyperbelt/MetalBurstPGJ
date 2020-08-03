extends Action

class_name ShootAngle

export(float) var _speed = 280
export(float) var _angle = 0

var _self = null
var _engine = null
var _projectile:ProjectileComponent = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	var defaultProjectile = get_blackboard()[BB.DPROJECTILE]
	_projectile = defaultProjectile.instance() if defaultProjectile!=null else Globals.DefaultProjectile.instance()


func _update_behavior(_delta:float)->int:
	
	var angle : float = _angle * (PI/180)
	
	shoot(_speed,angle,_self,_engine,_projectile)
	return RunState.Success


static func shoot(speed:float,angle:float,entity:Node2D,engine,projectile:ProjectileComponent):
	var bullet : ProjectileComponent = projectile
	var _realAngle = angle + PI/2
	bullet.projectile_init(
		entity.position,
		Vector2(cos(_realAngle),sin(_realAngle)),
		ProjectileComponent.ProjectileType.EnemyProjectile
	)
	bullet.position = entity.position
	bullet.set_speed(speed)
	engine.add_child(bullet)
