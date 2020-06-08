extends Action
#move in a cardinal direction
class_name MoveCardinal

enum Direction{
	North,
	NorthEast
	East,
	SouthEast
	South,
	SouthWest
	West,
	NorthWest
}

export(Direction) var _direction = Direction.South

var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]

func _update_behavior(_delta:float)->int:
	var newVelocity = Vector2(0,0)
	match _direction:
		Direction.North:
			newVelocity.y = -1
		Direction.NorthEast:
			newVelocity.y = -1
			newVelocity.x = 1
		Direction.East:
			newVelocity.x = 1
		Direction.SouthEast:
			newVelocity.x = 1
			newVelocity.y = 1
		Direction.South:
			newVelocity.y = 1
		Direction.SouthWest:
			newVelocity.y = 1
			newVelocity.x = -1
		Direction.West:
			newVelocity.x = -1
		Direction.NorthWest:
			newVelocity.x = -1
			newVelocity.y = -1
	print("%s before normal %s" % [Direction.keys()[_direction],newVelocity])
	newVelocity = newVelocity.normalized()
	print("%s  after normal  %s" % [Direction.keys()[_direction],newVelocity])
	newVelocity = Vector2(newVelocity.x * _self.get_max_speed(),newVelocity.y*_self.get_max_speed())
	_self.set_velocity(newVelocity.x,newVelocity.y)
	return RunState.Success
