tool
extends Action

#Shoot Action behavior - this is the one we want to transition into using.

class_name Shoot

const COLMAP = CollisionBits.CollisionBitMap

export(float) var _initialSpeed = 300 #optimally slow
export(float) var _initialHeading = 0 #in degrees
export(COLMAP) var _collisionLayer = COLMAP.Default #default layer collides with all other defaults
export(int,FLAGS,"Default","Background","Player","Enemy","EnemyBullet","PlayerBullet","PlayerBomb","Item") var _collisionMask
export(PackedScene) var _projectileScene
export(String,"Target","NoTarget") var _hasTarget

var _self = null
var _engine = null
var _target = null
var _projectile : ProjectileComponent= null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	_projectile = _projectileScene.instance() #projectileSceneMust not be null
	_projectile.set_collision_layer(_collisionLayer)
	_projectile.set_collision_mask(_collisionMask)
func _update_behavior(_delta:float)->int:
	shoot()
	return RunState.Success

func shoot():
	var angle = _initialHeading * PI/180

	var spawn_position : Vector2 = _self.global_position
	var initial_heading : Vector2 = Vector2(cos(angle),sin(angle))
	_projectile.projectile_init(spawn_position,initial_heading)
	_projectile.set_speed(_initialSpeed)
	# bullet.set_speed(speed)
	# bullet.set_velocity(cos(angle),sin(_initialHe))
	#bullet.change_speed(speed)
	_engine.add_child(_projectile)
	#var _value = Globals.audioManager.play_sound("sfx_foeShoot")

func _get_configuration_warning():
	return "Projectile Scene Cannot be null" if _projectileScene == null || !(_projectileScene is ProjectileComponent) else "" 