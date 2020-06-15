extends Action
#Action to move to the specified zone - this happened instantly <-:TODO make desc
class_name MoveTo

export(ZoneMap.Zones) var _zone = ZoneMap.Zones.TopLeft
export(float) var _xOffset = 0
export(float) var _yOffset = 0
export(bool) var _useValue = false #use value
export(String) var _valueName = "randomInt"

var _self = null
var _playContainer : ViewportContainer = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_playContainer = get_blackboard()[BB.PLAY_AREA]
	if(_useValue):
		_zone = get_blackboard()[_valueName] as int
	pass

func _update_behavior(_delta:float)->int:
	if(_self):
		_self.position = ZoneMap.get_zone_position(_zone,_playContainer) + Vector2(_xOffset,_yOffset)
		print("Zone is %s" % ZoneMap.Zones.keys()[_zone])
	
	return RunState.Success
