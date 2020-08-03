extends Action
###########################
# This is used to scale objects 
class_name ScaleTo

export (Vector2) var _scale = Vector2(2, 2)
export (float) var _time = 0
var _elapsed: float = 0

var _self = null
var _initialScale: Vector2 = Vector2.ZERO


func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_initialScale = _self.scale
	_elapsed = 0
	pass


func _update_behavior(delta: float) -> int:
	_elapsed += delta

	var a = 1.0 if _time <= 0 else min(_elapsed / _time, 1)
	_self.scale = Vector2(
		_initialScale.x + a * (_scale.x - _initialScale.x),
		_initialScale.y + a * (_scale.y - _initialScale.y)
	)
	if _elapsed >= _time:
		return RunState.Success
	return RunState.Running
