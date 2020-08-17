extends Action
#Change the collision bits of the object
#that this behavior is attached to
class_name ChangeCollision

const COLMAP = CollisionBits.CollisionBitMap
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


var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]


func _update_behavior(_delta:float)->int:

	if(_self.get("collision_mask")==null):
		return RunState.Failed #safe to assume that if no collision_mask then no collision_layer

	_self.collision_mask = _collisionMask
	_self.collision_layer = _collisionLayer

	return RunState.Success

