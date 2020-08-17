extends Action

class_name ShootDown

export(float) var _speed = 300

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
	shoot()
	return RunState.Success

func shoot():
	var bullet : ProjectileComponent = _projectile
	bullet.projectile_init(
			_self.position,
			Vector2(0, 1),
			ProjectileComponent.ProjectileType.EnemyProjectile
		)
	bullet.set_speed(_speed)
	_engine.add_child(bullet)
