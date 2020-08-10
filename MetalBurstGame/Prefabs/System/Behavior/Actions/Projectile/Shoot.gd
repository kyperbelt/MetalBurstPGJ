extends Action

#Shoot Action behavior - this is the one we want to transition into using.

class_name Shoot

const COLMAP = CollisionBits.CollisionBitMap

#if this is left at -1 we use default projectile speed
export (float) var _initialSpeed = -1  #optimally slow

#if -1 then use default scene damage
export(float) var _damage = -1 
#will ignore this speed here and use the 
#speed specified int he scne instance

export (float) var _initialHeading = 0  #in degrees

#default layer collides with all other defaults
export (COLMAP) var _collisionLayer = COLMAP.Default

#the collision mask flags used for this projectile
export (
	int,
	FLAGS,
	"Default",
	"Background",
	"Player",
	"Enemy",
	"EnemyBullet",
	"PlayerBullet",
	"PlayerBomb",
	"Item"
) var _collisionMask

#the scene of the projectile to shoot (OPTIONAL)
#if left null it will have the default projectile
export (PackedScene) var _projectileScene

#the behavior to use (OPTIONAL)
#if this is empty we will use the 
#default behavior for the projectile
export (PackedScene) var _behaviorScene

#get the target from the blackboard
export (String) var _targetName 
export (Vector2) var _offset

var _self = null
var _engine = null
var _target = null
var _projectile : ProjectileComponent= null


func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	var defaultProjectile = (
		get_blackboard()[BB.DPROJECTILE]
		if get_blackboard().has(BB.DPROJECTILE)
		else null
	)
	defaultProjectile = (
		defaultProjectile
		if defaultProjectile != null
		else Globals.DefaultProjectile
	)
	_projectile = (
		_projectileScene.instance()
		if _projectileScene != null
		else defaultProjectile.instance()
	)
	_projectile.set_collision_layer(_collisionLayer)
	_projectile.set_collision_mask(_collisionMask)
	if _behaviorScene != null:
		_projectile._behaviorScene = _behaviorScene

	_target = get_blackboard()[_targetName] if get_blackboard().has(_targetName) else null


func _update_behavior(_delta: float) -> int:
	shoot()
	return RunState.Success


func shoot():
	var angle = _initialHeading * PI / 180
	var angleTarget :float = 0 
	if _target != null:
		 angleTarget = atan2(_target.position.y - _self.position.y, _target.position.x - _self.position.x)
	angle += angleTarget

	var spawn_position: Vector2 = _self.global_position + _offset
	var initial_heading: Vector2 = Vector2(cos(angle), sin(angle))
	_projectile.projectile_init(spawn_position, initial_heading)
	if _initialSpeed>=0:
		_projectile.set_speed(_initialSpeed)
	if _damage>= 0:
		_projectile.set_damage(_damage)
	_engine.add_child(_projectile)


